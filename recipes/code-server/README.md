# code-server

Runs [code-server](https://github.com/coder/code-server) through Fungi's
Docker-compatible runtime path.

The recipe opens `${USER_HOME}` as `/home/coder/project` and exposes the
code-server web UI. The example password is `fungi`; change it before using the
recipe beyond local experiments.

