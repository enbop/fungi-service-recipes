#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
VERSION="${GITHUB_REF_NAME:-local}"

cd "$ROOT_DIR"

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required" >&2
  exit 1
fi

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

jq -e . index.json >/dev/null

recipe_count="$(jq '.recipes | length' index.json)"
if [[ "$recipe_count" -eq 0 ]]; then
  echo "index.json must contain at least one recipe" >&2
  exit 1
fi

while IFS=$'\t' read -r id manifest_path manifest_asset; do
  if [[ ! "$id" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
    echo "invalid recipe id: $id" >&2
    exit 1
  fi

  if [[ ! -f "$manifest_path" ]]; then
    echo "missing manifest for $id: $manifest_path" >&2
    exit 1
  fi

  expected_path="recipes/$id/$id.fungi.md"
  if [[ "$manifest_path" != "$expected_path" ]]; then
    echo "manifestPath for $id must be $expected_path" >&2
    exit 1
  fi

  expected_manifest_asset="$id.fungi.md"
  if [[ "$manifest_asset" != "$expected_manifest_asset" ]]; then
    echo "manifestAsset for $id must be $expected_manifest_asset" >&2
    exit 1
  fi

  if ! grep -q '^fungi: service/v1$' "$manifest_path"; then
    echo "service file for $id is missing fungi: service/v1" >&2
    exit 1
  fi

  if ! grep -q "^id: $id$" "$manifest_path"; then
    echo "service file for $id must declare id: $id" >&2
    exit 1
  fi

  if grep -q '^name:' "$manifest_path"; then
    echo "service file for $id must use id, not name" >&2
    exit 1
  fi

  if ! grep -q '^---$' "$manifest_path"; then
    echo "service file for $id is missing YAML front matter delimiter" >&2
    exit 1
  fi

  cp "$manifest_path" "$DIST_DIR/$manifest_asset"
done < <(jq -r '.recipes[] | [.id, .manifestPath, .manifestAsset] | @tsv' index.json)

cp index.json "$DIST_DIR/index.json"

(
  cd "$DIST_DIR"
  sha256sum index.json *.fungi.md > SHA256SUMS
)

cat > "$DIST_DIR/RELEASE_NOTES.md" <<EOF
Fungi Service Recipes ${VERSION}

Static assets:

- index.json
- <recipe-id>.fungi.md
- SHA256SUMS

This is an experimental recipe collection, not a curated service hub or security-reviewed registry.
EOF

echo "Built release payload in $DIST_DIR"
