# File Browser Lite

Runs [filebrowser-lite](https://github.com/enbop/filebrowser-lite) through
Fungi's Wasmtime runtime path.

The recipe downloads the pinned `lite-v0.2.0` WASI component and serves
`${USER_HOME}` through a browser UI.
