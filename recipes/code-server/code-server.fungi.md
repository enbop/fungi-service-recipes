---
fungi: service/v1
name: code-server

run:
  provider: docker
  source:
    image: ghcr.io/coder/code-server:4.117.0
  args:
    - --auth
    - none
    - /home/coder/project
  mounts:
    - from: $fungi.workspace
      to: /home/coder/project

publish:
  http:
    tcp:
      port: 8080
    client:
      kind: web
      path: /
---

# code-server

Runs [code-server](https://github.com/coder/code-server) through Fungi's
Docker-compatible runtime path.

This recipe opens `$fungi.workspace` as `/home/coder/project` and exposes the
code-server web UI.

## Safety

Authentication is disabled so Fungi can open the service without a separate
password prompt. Apply this recipe only for trusted Fungi devices that should be
allowed to reach this editor.

## Source

- Upstream project: <https://github.com/coder/code-server>
- Container image: `ghcr.io/coder/code-server:4.117.0`
