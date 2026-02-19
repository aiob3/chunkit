#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$ROOT_DIR/scripts/update_metadata.sh" > /tmp/metadata1.yml
"$ROOT_DIR/scripts/update_metadata.sh" > /tmp/metadata2.yml
diff /tmp/metadata1.yml /tmp/metadata2.yml >/dev/null || exit 1
echo "✓ Idempotência validada"
