#!/bin/bash

set -euo pipefail

echo "Setting up the environment..."

mkdir -p "$HOME/.config"

link_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ]; then
        echo "Backing up existing file: $dest"
        mv "$dest" "${dest}.bak"
    fi

    echo "Linking: $dest -> $src"
    ln -s "$src" "$dest"
}

link_file "$PWD/.config/nvim" "$HOME/.config/nvim"

echo "Setup complete!"