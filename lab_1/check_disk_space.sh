#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $0 [THRESHOLD_PERCENT] [MOUNT_POINT...]" >&2
    exit 2
}

threshold=${1:-10}
if [[ ! $threshold =~ ^[0-9]+$ ]] || ((threshold > 100)); then
    usage
fi
if (($# > 0)); then
    shift
fi
mount_points=("${@:-/}")

report=$(df --output=size,avail,target -- "${mount_points[@]}")

low_space=0
while read -r size available target; do
    if ((size == 0)); then
        echo "SKIP: ${target} has no disk space (virtual filesystem)"
        continue
    fi
    free=$((available * 100 / size))
    if ((free < threshold)); then
        echo "WARNING: ${target} has only ${free}% free space (threshold ${threshold}%)"
        low_space=1
    else
        echo "OK: ${target} has ${free}% free space (threshold ${threshold}%)"
    fi
done < <(tail -n +2 <<<"$report")

exit "$low_space"
