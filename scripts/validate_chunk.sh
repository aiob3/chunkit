#!/usr/bin/env bash

set -euo pipefail

usage() {
  echo "✗ Uso: ./scripts/validate_chunk.sh <caminho-do-chunk.skill.md>"
  exit 1
}

[[ $# -eq 1 ]] || usage

CHUNK_FILE="$1"
[[ -f "$CHUNK_FILE" ]] || { echo "✗ Arquivo não encontrado: $CHUNK_FILE"; exit 1; }

has_section() {
  local pattern="$1"
  grep -qE "$pattern" "$CHUNK_FILE"
}

l1_points=0
has_section "^### 1\\. Intake" && l1_points=$((l1_points + 1))
has_section "^### 2\\. Meios" && l1_points=$((l1_points + 1))
has_section "^### 3\\. Insights" && l1_points=$((l1_points + 1))
has_section "^### 1\\. (Feature Spec / Chunk Spec|Chunk Spec)" && l1_points=$((l1_points + 1))
has_section "^### 2\\. (Snippet Técnico / Schema|Schema / Assinatura)" && l1_points=$((l1_points + 1))
has_section "^### 3\\. Guia de (Adoção|Uso)" && l1_points=$((l1_points + 1))

l1_cov=$((l1_points * 100 / 6))

placeholder_count="$(grep -oE '<[^>]+>|TBD|<Aguardando>|<%>|<calc>' "$CHUNK_FILE" | wc -l | tr -d ' ')"
total_lines="$(wc -l <"$CHUNK_FILE" | tr -d ' ')"
if [[ "$total_lines" -eq 0 ]]; then
  l2_cov=0
  l3_cov=0
else
  fill_ratio=$((100 - (placeholder_count * 100 / total_lines)))
  ((fill_ratio < 0)) && fill_ratio=0
  l2_cov="$fill_ratio"
  l3_cov="$fill_ratio"
fi

l4_cov=0
has_section "^### Tags" && l4_cov=$((l4_cov + 34))
has_section "^### Cross-References" && l4_cov=$((l4_cov + 33))
has_section "^### Invariantes Aplicadas" && l4_cov=$((l4_cov + 33))

l5_cov=0
has_section "^## PARTE D: AUTO-AVALIAÇÃO" && l5_cov=100

score="$(awk -v l1="$l1_cov" -v l2="$l2_cov" -v l3="$l3_cov" -v l4="$l4_cov" -v l5="$l5_cov" 'BEGIN{
  total=5 + (15*l1/100) + (20*l2/100) + (25*l3/100) + (15*l4/100) + (20*l5/100);
  printf "%.0f", total
}')"

validation_command="$(grep -E '^VALIDATION_COMMAND[[:space:]]*=' "$CHUNK_FILE" | sed 's/^[^=]*=[[:space:]]*//' | head -n1 || true)"
if [[ -n "$validation_command" ]]; then
  echo "→ Executando VALIDATION_COMMAND: $validation_command"
  bash -lc "$validation_command" || {
    echo "✗ VALIDATION_COMMAND falhou"
    exit 1
  }
fi

status="REQUER_ITERACAO"
exit_code=1
if [[ "$score" -ge 80 ]]; then
  status="APROVADO"
  exit_code=0
fi

echo "Score: ${score}/100 | Status: ${status}"
exit "$exit_code"
