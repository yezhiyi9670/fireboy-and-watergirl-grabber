#!/bin/bash

set -euo pipefail

source "$(dirname "$0")/include/vars.sh"

if [[ -f upload.zip ]]; then
    rm upload.zip
fi
(
    fd -t f --hidden --exclude ".git" -0 --glob "*" "${games[@]}" homepage/dist homepage/api;
    echo -n "index.php"$'\0';
) | xargs -0 zip upload.zip
