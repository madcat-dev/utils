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

if ! cd "$PREFIX/bin"; then
    echo "PREFIX-path not existing"
    exit 1
fi

if ! rm -f $(ls "$BASE/bin"); then
    echo "Error of remove files"
    exit 1
fi

echo "Uninstall successfully!"
