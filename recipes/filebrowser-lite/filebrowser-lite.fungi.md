---
fungi: service/v1
id: filebrowser-lite

run:
  provider: wasmtime
  source:
    url: https://github.com/enbop/filebrowser-lite/releases/download/lite-v0.4.0/filebrowser-lite-wasi.wasm
  args:
    - --listen
    - 127.0.0.1:8082
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

This recipe downloads the pinned `lite-v0.4.0` WASIp2 command. One long-running
component owns the Tokio HTTP listener and serves `$fungi.workspace` through a
browser UI.

## Source

- Project: <https://github.com/enbop/filebrowser-lite/tree/master/filebrowser-lite-wasi>
- Artifact URL: <https://github.com/enbop/filebrowser-lite/releases/download/lite-v0.4.0/filebrowser-lite-wasi.wasm>
