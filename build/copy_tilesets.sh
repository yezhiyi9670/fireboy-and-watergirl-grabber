#!/bin/bash

set -euo pipefail

source "$(dirname "$0")/include/vars.sh"

for game in "${games[@]}"; do
    dir="_grabber/tiled-atlasses/$game"
    if [[ ! -d "$dir" ]]; then
        mkdir "$dir"
    fi
    cp -r "$game/dist/assets/tilemaps/tilesets/"/*.png "$dir"
    cp -r "$game/dist/assets/tilemaps/tilesets/"/default_level.json "$dir"
    echo "$dir"
done
