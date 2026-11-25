#!/usr/bin/env bash
set -euo pipefail

directory=$(date +%Y-%m-%d)

if [[ -d $directory ]]; then
    echo "Directory exists: ${directory}"
else
    mkdir -- "$directory"
    echo "Directory created: ${directory}"
fi
