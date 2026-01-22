#!/bin/bash
tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
sleep 2
tailscale up ${TS_EXTRA_ARGS}
#!/usr/bin/env bash


set -e

GITHUB_USER="amingilani"
LOCALUSER="remnux"
AUTHORIZED_KEYS="/home/${LOCALUSER}/.ssh/authorized_keys"

# Create .ssh directory if it doesn't exist
mkdir -p "/home/${LOCALUSER}/.ssh"
chmod 700 "/home/${LOCALUSER}/.ssh"

# Fetch keys from GitHub
echo "Fetching SSH keys for ${GITHUB_USER}..."
KEYS=$(curl -sSL "https://github.com/${GITHUB_USER}.keys")

if [ -z "$KEYS" ]; then
    echo "Error: No keys found for user ${GITHUB_USER}"
    exit 1
fi

# Backup existing authorized_keys if it exists
if [ -f "$AUTHORIZED_KEYS" ]; then
    cp "$AUTHORIZED_KEYS" "${AUTHORIZED_KEYS}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backed up existing authorized_keys"
fi

# Add keys with comment
echo "# GitHub keys for ${GITHUB_USER} - added $(date)" >> "$AUTHORIZED_KEYS"
echo "$KEYS" >> "$AUTHORIZED_KEYS"

# Set proper permissions
chmod 600 "$AUTHORIZED_KEYS"

echo "Successfully added keys to ${AUTHORIZED_KEYS}"
echo ""
echo "Added keys:"
echo "$KEYS"

exec /usr/sbin/sshd -D