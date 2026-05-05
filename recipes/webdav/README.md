# WebDAV

Runs [webdav-wasi](https://github.com/enbop/webdav-wasi) through Fungi's
Wasmtime runtime path.

The recipe serves `${USER_HOME}` as a WebDAV endpoint. It is marked as a TCP
entry because the experimental component currently responds correctly to WebDAV
clients such as `PROPFIND`, while a plain browser `GET /` is not a useful health
check.
