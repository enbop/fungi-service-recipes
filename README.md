# Fungi Service Recipes

Experimental service manifest recipes for [Fungi](https://github.com/enbop/fungi).

This repository is a lightweight collection of runnable references and starting
points. It is not a curated service hub, marketplace, or security-reviewed
registry. Recipes can change, break, disappear, or move as the Fungi service
manifest format evolves.

## Release Assets

Tagged releases publish static assets that can be fetched over HTTP:

- `index.json`: recipe metadata and manifest paths.
- `<recipe-id>.fungi.md`: a directly fetchable service file with YAML front matter and Markdown notes.
- `SHA256SUMS`: checksums for the published assets.

The source layout intentionally mirrors the release layout:

```text
recipes/
  <recipe-id>/
    <recipe-id>.fungi.md
index.json
```

## Current Recipes

- `code-server`: code-server through the Docker-compatible runtime.
- `filebrowser-lite`: File Browser Lite through the Wasmtime runtime.
- `ssh-tunnel`: an existing SSH daemon exposed as a TCP tunnel service.
- `webdav`: WebDAV through the Wasmtime runtime.

## Local Build

Build and validate the static release payload:

```bash
scripts/build-release.sh
```

The generated files are written to `dist/`.

## Adding A Recipe

1. Add `recipes/<recipe-id>/<recipe-id>.fungi.md`.
2. Put the structured service definition in YAML front matter and the human/AI notes in the Markdown body.
3. Add the recipe entry to `index.json`.
4. Run `scripts/build-release.sh`.

Keep entries experimental unless there is an explicit compatibility and review
process behind them.
