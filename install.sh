#!/usr/bin/env bash

BASE="$(dirname "${BASH_SOURCE:-$0}")"
PREFIX="$HOME/.local"

[ $(id -u) -eq 0 ] && PREFIX="/usr/local"

while [ -n "$1" ]; do
    case "${1}" in
    --prefix)
        PREFIX="$(realpath "${2}")"
        ;;
    esac
    shift
done

mkdir -p "$PREFIX/bin" > /dev/null 2>&1

if ! cp -xar "$BASE/bin" "$PREFIX"; then
    echo "Error of copy files!"
    exit 1
fi

echo "Install successfully!"
