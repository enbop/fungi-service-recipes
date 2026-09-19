---
fungi: service/v1
id: webdav

run:
  provider: wasmtime
  source:
    url: https://github.com/enbop/webdav-wasi/releases/download/v0.2.0/webdav-wasi.wasm
  args:
    - --addr
    - 127.0.0.1:8080
  env:
    WEBDAV_FS_ROOT: data
  mounts:
    - from: $fungi.workspace
      to: data

publish:
  webdav:
    tcp:
      port: 8080
    client:
      kind: webdav
---

# WebDAV

Runs [webdav-wasi](https://github.com/enbop/webdav-wasi) through Fungi's
Wasmtime runtime path.

One long-running WASIp2 command owns the Tokio HTTP listener and serves
`$fungi.workspace` as a WebDAV endpoint.

## Usage

Use a WebDAV client against the printed local address. Browser `GET /` is not a
useful health check for this experimental component.

## Source

- Project: <https://github.com/enbop/webdav-wasi>
- Artifact URL: <https://github.com/enbop/webdav-wasi/releases/download/v0.2.0/webdav-wasi.wasm>
