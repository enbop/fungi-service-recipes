# code-server

Runs [code-server](https://github.com/coder/code-server) through Fungi's
Docker-compatible runtime path.

The recipe opens `${USER_HOME}` as `/home/coder/project` and exposes the
code-server web UI. Authentication is disabled so Fungi can open the service
without a separate password prompt; trust only devices that should be allowed to
reach this editor.
