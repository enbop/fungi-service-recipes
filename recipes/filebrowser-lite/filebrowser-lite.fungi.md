---
fungi: service/v1
name: filebrowser-lite

run:
  provider: wasmtime
  mode: http
  source:
    url: https://github.com/enbop/filebrowser-lite/releases/download/lite-v0.2.0/filebrowser-lite-wasi.wasm
  mounts:
    - from: $fungi.workspace
      to: data

publish:
  http:
    tcp:
      port: 8082
    client:
      kind: web
      path: /
---

# File Browser Lite

Runs [filebrowser-lite](https://github.com/enbop/filebrowser-lite) through
Fungi's Wasmtime runtime path.

This recipe downloads the pinned `lite-v0.2.0` WASI component and serves
`$fungi.workspace` through a browser UI.

## Source

- Project: <https://github.com/enbop/filebrowser-lite/tree/master/filebrowser-lite-wasi>
- Artifact URL: <https://github.com/enbop/filebrowser-lite/releases/download/lite-v0.2.0/filebrowser-lite-wasi.wasm>
