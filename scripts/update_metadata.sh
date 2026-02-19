#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
METADATA_FILE="$ROOT_DIR/convergence-metadata.yml"
OUTPUT_DIR="$ROOT_DIR/chunkit-output"
TMP_FILE="$(mktemp)"
NOW_UTC="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

default_tail() {
  cat <<'EOF'
cross_references:
  upstream:
    - name: llm-readable-kit
      repo: aiob3/llm-readable-kit
      type: structural_dependency
  downstream: []

validation:
  scoring_threshold: 80
  hitl_required: true
  tests: []

governance:
  scoring_system: L0-L5 (logarithmic)
  hitl_gate: mandatory
  idempotence_policy: deterministic_inputs_outputs
EOF
}

ensure_metadata_file() {
  if [[ -f "$METADATA_FILE" ]]; then
    return
  fi

  cat >"$METADATA_FILE" <<EOF
version: 1.0
project:
  name: chunkit
  id_mestre: 180226-234000
  type: framework
  created_at: 2026-02-19T03:14:07Z
  updated_at: ${NOW_UTC}

chunks: []

$(default_tail)
EOF
}

extract_chunk_field() {
  local file="$1"
  local pattern="$2"
  head -n 25 "$file" | sed -n "s/^\\*\\*${pattern}:\\*\\*[[:space:]]*//p" | head -n1 | sed 's/[[:space:]]*$//'
}

extract_tags() {
  local file="$1"
  local line
  line="$(awk '/^### Tags/{getline; while ($0 ~ /^[[:space:]]*$/) getline; print; exit}' "$file")"
  if [[ -z "$line" ]]; then
    return
  fi
  echo "$line" | grep -oE '`[^`]+`' | sed 's/^`//;s/`$//' | sed '/^$/d'
}

extract_depends() {
  local file="$1"
  sed -n 's/^- \*\*Depende de:\*\* `\([^`]*\)`/\1/p' "$file"
}

old_chunk_block() {
  local chunk_id="$1"
  awk -v id="$chunk_id" '
    $1=="-" && $2=="id:" && $3==id {capture=1}
    capture {print}
    capture && /^  - id:/ && $3!=id {exit}
  ' "$METADATA_FILE"
}

old_field() {
  local chunk_id="$1"
  local field="$2"
  old_chunk_block "$chunk_id" | awk -v key="$field" '$1==key":" {sub($1 FS,""); sub(/^[[:space:]]+/,""); print; exit}'
}

ensure_metadata_file

HEADER="$(mktemp)"
TAIL="$(mktemp)"

awk 'BEGIN{capture=1} /^chunks:/{capture=0} capture{print}' "$METADATA_FILE" >"$HEADER"
if grep -q '^cross_references:' "$METADATA_FILE"; then
  awk 'BEGIN{capture=0} /^cross_references:/{capture=1} capture{print}' "$METADATA_FILE" >"$TAIL"
else
  default_tail >"$TAIL"
fi

{
  cat "$HEADER"
  echo
  echo "chunks:"
} >"$TMP_FILE"

mapfile -t chunk_files < <(find "$OUTPUT_DIR" -maxdepth 1 -name 'chunkit.*.skill.md' -type f | sort)

for file in "${chunk_files[@]}"; do
  base="$(basename "$file" .skill.md)"
  chunk_id="$base"
  type="$(echo "$base" | sed -E 's/^chunkit\.([^-]+)-.*$/\1/')"
  escopo="$(extract_chunk_field "$file" "Escopo")"
  [[ -n "$escopo" ]] || escopo="$(echo "$base" | sed -E 's/^chunkit\.[^-]+-(.*)$/\1/')"
  id_mestre="$(extract_chunk_field "$file" "ID Mestre")"
  status_raw="$(extract_chunk_field "$file" "Status")"
  created_at="$(old_field "$chunk_id" "created_at")"
  [[ -n "$created_at" ]] || created_at="$NOW_UTC"

  status="PENDENTE_HITL"
  if [[ "$status_raw" == *"APROVADO"* ]]; then
    status="APROVADO"
  fi
  old_status="$(old_field "$chunk_id" "status")"
  if [[ -n "$old_status" && "$old_status" != "PENDENTE_HITL" ]]; then
    status="$old_status"
  fi

  approved_at="$(old_field "$chunk_id" "approved_at")"
  approved_by="$(old_field "$chunk_id" "approved_by")"
  [[ -n "$approved_at" ]] || approved_at="null"
  [[ -n "$approved_by" ]] || approved_by="null"

  {
    echo "  - id: $chunk_id"
    echo "    file: chunkit-output/$(basename "$file")"
    echo "    type: $type"
    echo "    escopo: $escopo"
    echo "    status: $status"
    echo "    created_at: $created_at"
    echo "    id_mestre: $id_mestre"
    echo "    tags:"
  } >>"$TMP_FILE"

  tags_count=0
  while IFS= read -r tag; do
    [[ -n "$tag" ]] || continue
    echo "      - $tag" >>"$TMP_FILE"
    tags_count=1
  done < <(extract_tags "$file")
  if [[ "$tags_count" -eq 0 ]]; then
    echo "      - META:pending-classification" >>"$TMP_FILE"
  fi

  dep_lines=""
  deps_count=0
  while IFS= read -r dep; do
    [[ -n "$dep" ]] || continue
    dep_lines="${dep_lines}      - ${dep}"$'\n'
    deps_count=1
  done < <(extract_depends "$file")
  if [[ "$deps_count" -eq 0 ]]; then
    echo "    depends_on: []" >>"$TMP_FILE"
  else
    echo "    depends_on:" >>"$TMP_FILE"
    printf "%s" "$dep_lines" >>"$TMP_FILE"
  fi

  echo "    used_by: []" >>"$TMP_FILE"
  echo "    approved_at: $approved_at" >>"$TMP_FILE"
  echo "    approved_by: $approved_by" >>"$TMP_FILE"
done

echo >>"$TMP_FILE"
cat "$TAIL" >>"$TMP_FILE"

awk '{
  if ($0 ~ /^[[:space:]]*$/) {
    if (!blank) print ""
    blank=1
  } else {
    print
    blank=0
  }
}' "$TMP_FILE" >"$METADATA_FILE"

if ! command -v yamllint >/dev/null 2>&1; then
  python3 -m pip install --user yamllint >/dev/null 2>&1 || true
  export PATH="$HOME/.local/bin:$PATH"
fi

if command -v yamllint >/dev/null 2>&1; then
  yamllint -d '{extends: relaxed, rules: {empty-lines: disable, trailing-spaces: disable}}' "$METADATA_FILE" >/dev/null
else
  echo "⚠ yamllint não disponível; validação de schema ignorada" >&2
fi

echo "✓ Metadata sincronizada: convergence-metadata.yml"
cat "$METADATA_FILE"
