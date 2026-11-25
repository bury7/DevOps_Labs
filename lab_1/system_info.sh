#!/usr/bin/env bash
set -euo pipefail

echo "Hostname: $(hostname)"

echo "IP addresses (without loopback):"
ip -o address show | grep -vw lo | awk '{ printf "  %-12s %-6s %s\n", $2, $3, $4 }'

echo "Kernel:   $(uname -r)"
echo "Uptime:   $(uptime -p) (since $(uptime -s))"
echo "User:     $(whoami)"
