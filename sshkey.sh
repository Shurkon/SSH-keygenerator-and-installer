#!/usr/bin/env bash
set -e

usage() {

  cat <<EOF
Usage: $0

This script will:
1. Generate an RSA 4096-bit SSH key in ~/.ssh/
2. Copy the public key to the remote server's authorized_keys

You will be prompted for:
- SSH key name
- Server IP or hostname
- SSH username
- SSH port (default: 22)

Options:
  -h, --help    Show this help message and exit

EOF

  exit 0

}

# Show help if requested
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
fi

echo "=== SSH Key Generator & Installer ==="

# Prompt for input
read -p "SSH key name (e.g., my_key): " KEYNAME
read -p "Server IP or hostname: " SERVER_IP
read -p "SSH username: " SSH_USER
read -p "SSH port [default 22]: " PORT
PORT=${PORT:-22}

# Generate the SSH key
ssh-keygen -t rsa -b 4096 -C "$SSH_USER@$SERVER_IP" -f ~/.ssh/"$KEYNAME" -N ""

# Copy the public key to the server using the specified port
cat ~/.ssh/"$KEYNAME".pub | ssh -p "$PORT" "$SSH_USER@$SERVER_IP" \
  "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh"

echo "[i] Your key ~/.ssh/$KEYNAME has been added to $SSH_USER@$SERVER_IP on port $PORT"

