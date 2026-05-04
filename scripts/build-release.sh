#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
PAYLOAD_DIR="$DIST_DIR/fungi-service-recipes"
VERSION="${GITHUB_REF_NAME:-local}"

cd "$ROOT_DIR"

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required" >&2
  exit 1
fi

rm -rf "$DIST_DIR"
mkdir -p "$PAYLOAD_DIR"

jq -e . index.json >/dev/null

recipe_count="$(jq '.recipes | length' index.json)"
if [[ "$recipe_count" -eq 0 ]]; then
  echo "index.json must contain at least one recipe" >&2
  exit 1
fi

while IFS=$'\t' read -r id manifest_path; do
  if [[ ! "$id" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
    echo "invalid recipe id: $id" >&2
    exit 1
  fi

  if [[ ! -f "$manifest_path" ]]; then
    echo "missing manifest for $id: $manifest_path" >&2
    exit 1
  fi

  expected_path="recipes/$id/manifest.yaml"
  if [[ "$manifest_path" != "$expected_path" ]]; then
    echo "manifestPath for $id must be $expected_path" >&2
    exit 1
  fi

  if [[ ! -f "recipes/$id/README.md" ]]; then
    echo "missing README for $id: recipes/$id/README.md" >&2
    exit 1
  fi

  if ! grep -q '^apiVersion: fungi.rs/' "$manifest_path"; then
    echo "manifest for $id is missing a Fungi apiVersion" >&2
    exit 1
  fi

  if ! grep -q '^kind: ServiceManifest$' "$manifest_path"; then
    echo "manifest for $id is missing kind: ServiceManifest" >&2
    exit 1
  fi
done < <(jq -r '.recipes[] | [.id, .manifestPath] | @tsv' index.json)

cp README.md LICENSE index.json "$PAYLOAD_DIR/"
cp -R recipes "$PAYLOAD_DIR/"

cp index.json "$DIST_DIR/index.json"

tar -C "$DIST_DIR" -czf "$DIST_DIR/manifests.tar.gz" fungi-service-recipes

(
  cd "$DIST_DIR"
  zip -qr manifests.zip fungi-service-recipes
)

(
  cd "$DIST_DIR"
  sha256sum index.json manifests.tar.gz manifests.zip > SHA256SUMS
)

cat > "$DIST_DIR/RELEASE_NOTES.md" <<EOF
Fungi Service Recipes ${VERSION}

Static assets:

- index.json
- manifests.tar.gz
- manifests.zip
- SHA256SUMS

This is an experimental recipe collection, not a curated service hub or security-reviewed registry.
EOF

echo "Built release payload in $DIST_DIR"
