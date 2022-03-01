#!/usr/bin/env bash

BASE="$(dirname "${BASH_SOURCE:-$0}")"
PREFIX="$HOME/.local"

while [ -n "$1" ]; do
    case "${1}" in
    --prefix)
        PREFIX="$(realpath "${2}")"
        ;;
    esac
    shift
done

mkdir -p "$PREFIX/bin" 2>/dev/null

if ! cp -xar "$BASE/bin" "$PREFIX"; then
    echo -e "\033[31m- Error of copy bin files\033[0m"
    exit 1
fi

echo -e "\033[32mInstall successfully!\033[0m"
