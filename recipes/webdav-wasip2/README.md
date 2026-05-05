# WebDAV WASI Preview

Runs [webdav-wasip2](https://github.com/enbop/webdav-wasip2) through Fungi's
Wasmtime runtime path.

The recipe serves `${USER_HOME}` as a WebDAV endpoint. It is marked as a TCP
entry because the experimental component currently responds correctly to WebDAV
clients such as `PROPFIND`, while a plain browser `GET /` is not a useful health
check.

