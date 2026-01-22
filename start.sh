#!/bin/bash
tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
sleep 2
tailscale up ${TS_EXTRA_ARGS}
exec /usr/sbin/sshd -D