# File Browser

Runs [File Browser](https://github.com/filebrowser/filebrowser) through Fungi's
Docker-compatible runtime path.

The recipe stores data under `${APP_HOME}/data`, exposes the service as a web
TCP endpoint, and asks Fungi to choose an available host port with
`hostPort: auto`.
