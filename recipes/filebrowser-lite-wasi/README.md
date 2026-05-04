# File Browser Lite WASI

Runs [filebrowser-lite](https://github.com/enbop/filebrowser-lite) through
Fungi's Wasmtime runtime path.

The recipe downloads the latest `filebrowser-lite-wasi.wasm` release artifact,
stores data under `${APP_HOME}/data`, exposes the service as a web TCP endpoint,
and asks Fungi to choose an available host port with `hostPort: auto`.
