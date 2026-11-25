#!/usr/bin/env bash
set -euo pipefail

if (($# != 2)) || [[ -z ${2#.} ]]; then
    echo "Usage: $0 DIRECTORY EXTENSION" >&2
    exit 2
fi

directory=$1
extension=${2#.}
if [[ ! -d $directory ]]; then
    echo "Not a directory: ${directory}" >&2
    exit 1
fi

count=$(find "$directory" -type f -name "*.${extension}" -printf '.' | wc -c)
echo "Directory ${directory} has ${count} files with extension .${extension}."
