# SSH

Turns an existing SSH daemon on the target device into a Fungi TCP tunnel
service.

This recipe does not install or start SSH. It only publishes
`127.0.0.1:22` from the target device as `ssh`, so users can attach local access
with Fungi and then connect with their normal SSH client. Across devices, the
service is naturally addressed as `ssh@nas`, `ssh@workstation`, and so on.
