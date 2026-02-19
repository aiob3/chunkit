#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="$ROOT_DIR/chunkit-output"
TEMPLATE_FILE="$OUTPUT_DIR/TEMPLATE.chunkit.skill.md"

usage() {
  echo "✗ Uso: ./scripts/new_chunk.sh <blueprint|reference|scaffold|validation> <escopo-kebab-case>"
  exit 1
}

[[ $# -eq 2 ]] || usage

CHUNK_TYPE="$1"
CHUNK_SCOPE="$2"

case "$CHUNK_TYPE" in
  blueprint|reference|scaffold|validation) ;;
  *)
    echo "✗ CHUNK_TYPE inválido: $CHUNK_TYPE"
    exit 1
    ;;
esac

if [[ ! "$CHUNK_SCOPE" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "✗ CHUNK_SCOPE deve estar em kebab-case"
  exit 1
fi

if [[ ! -f "$TEMPLATE_FILE" ]]; then
  echo "✗ Template não encontrado: $TEMPLATE_FILE"
  exit 2
fi

ID_MESTRE="$(TZ=America/Sao_Paulo date +%d%m%y-%H%M%S)"
TARGET_FILE="$OUTPUT_DIR/chunkit.${CHUNK_TYPE}-${CHUNK_SCOPE}.skill.md"

if [[ -f "$TARGET_FILE" ]]; then
  echo "⚠ Chunk já existe: $TARGET_FILE"
  exit 1
fi

cp "$TEMPLATE_FILE" "$TARGET_FILE"
sed -i \
  -e "1s|^# .*|# chunkit.${CHUNK_TYPE}-${CHUNK_SCOPE}.skill.md|" \
  -e "s|^\\*\\*ID Mestre:\\*\\* .*|**ID Mestre:** ${ID_MESTRE}|" \
  -e "s|^\\*\\*Tipo:\\*\\* .*|**Tipo:** ${CHUNK_TYPE}|" \
  "$TARGET_FILE"

if grep -q "^\\*\\*Escopo:\\*\\*" "$TARGET_FILE"; then
  sed -i -e "s|^\\*\\*Escopo:\\*\\* .*|**Escopo:** ${CHUNK_SCOPE}|" "$TARGET_FILE"
else
  sed -i "5i**Escopo:** ${CHUNK_SCOPE}" "$TARGET_FILE"
fi

"$ROOT_DIR/scripts/update_metadata.sh" >/dev/null

echo "✓ Chunk criado: chunkit-output/chunkit.${CHUNK_TYPE}-${CHUNK_SCOPE}.skill.md | Status: PENDENTE_HITL"
