#!/bin/bash

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: path/to/make_zip.sh <game_id_or_'homepage's> ..." >&2
    exit 1
fi

source "$(dirname "$0")/include/vars.sh"

dist_items=()
for specifier in "$@"; do
    if echo " ${games[@]} " | grep " $specifier " >/dev/null; then
        echo "Game:" "$specifier"
        dist_items+=( "$specifier" )
    elif [[ "${specifier:0:1}" == "^" ]] && (echo " ${games[@]} " | grep " ${specifier:1} " >/dev/null); then
        echo "Game (data only):" "${specifier:1}"
        dist_items+=( "${specifier:1}/dist/data" )
    elif [[ "$specifier" == "homepage" ]]; then
        echo "Homepage:" "$specifier"
        dist_items+=( homepage/dist homepage/api )
    else
        echo "Invalid specifier:" "$specifier" >&2
        exit 2
    fi
done

if [[ -f upload.zip ]]; then
    rm upload.zip
fi
(
    fd -t f --hidden --exclude ".git" -0 --glob "*" "${dist_items[@]}"
) | xargs -0 zip upload.zip
