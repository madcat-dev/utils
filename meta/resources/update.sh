#!/usr/bin/env bash

BASE="$(dirname "${BASH_SOURCE:-$0}")"

cp ~/.vimrc "$BASE/.vimrc" \
    || echo "File .vimrc is not updated..."

cp ~/.zshrc "$BASE/.zshrc" \
    || echo "File .zshrc is not updated..."

