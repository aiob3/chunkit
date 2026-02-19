#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
METADATA_FILE="$ROOT_DIR/convergence-metadata.yml"

usage() {
  echo "✗ Uso: ./scripts/promote_chunk.sh <caminho-do-chunk.skill.md>"
  exit 1
}

[[ $# -eq 1 ]] || usage

CHUNK_FILE="$1"
[[ -f "$CHUNK_FILE" ]] || { echo "✗ Arquivo não encontrado: $CHUNK_FILE"; exit 1; }

if ! head -n 25 "$CHUNK_FILE" | grep -qE '^\*\*Status:\*\*.*APROVADO'; then
  echo "✗ Chunk ainda não está APROVADO no arquivo. Status HITL pendente."
  exit 1
fi

chunk_base="$(basename "$CHUNK_FILE" .skill.md)"
approved_at="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
id_mestre="$(sed -n 's/^\*\*ID Mestre:\*\*[[:space:]]*//p' "$CHUNK_FILE" | head -n1)"

"$ROOT_DIR/scripts/update_metadata.sh" >/dev/null

awk -v id="$chunk_base" -v at="$approved_at" '
  $1=="-" && $2=="id:" && $3==id {in_chunk=1}
  in_chunk && $1=="status:" {$0="    status: APROVADO"}
  in_chunk && $1=="approved_at:" {$0="    approved_at: " at}
  in_chunk && $1=="approved_by:" && $2=="null" {$0="    approved_by: HITL"}
  in_chunk && /^  - id:/ && $3!=id {in_chunk=0}
  {print}
' "$METADATA_FILE" >"$METADATA_FILE.tmp"
mv "$METADATA_FILE.tmp" "$METADATA_FILE"

commit_hash="N/A"
if git -C "$ROOT_DIR" add "$CHUNK_FILE" "$METADATA_FILE" >/dev/null 2>&1 && \
   git -C "$ROOT_DIR" commit -m "chore: promote chunk ${chunk_base} (ID: ${id_mestre})" >/dev/null 2>&1; then
  commit_hash="$(git -C "$ROOT_DIR" rev-parse --short HEAD)"
fi

echo "✓ Chunk promovido: ${CHUNK_FILE} | Commit: ${commit_hash}"
