#!/usr/bin/env bash

DIFF=$(date '+%s')
declare -A BACKUP_GROUPS
FILES=()


function displaytime {
    local T=$1
    local W=$((T/60/60/24/7))
    local D=$((T/60/60/24%7))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))

    if [[ $W > 0 ]]; then
        printf '%d weeks ' $W
        printf '%d days ' $D
    else
        if [[ $D > 0 ]]; then
            printf '%d days ' $D
            printf '%d hours ' $H
        else
            [[ $H > 0 ]] && printf '%d hours ' $H
            [[ $M > 0 ]] && printf '%d minutes ' $M
            [[ $H = 0 ]] && printf '%d seconds ' $S
        fi
    fi

    printf 'ago'
}

function show_group() {
    local tname="/tmp/bk.$$"
    local fg="$(cat $tname 2>/dev/null)"

    if [[ "${fg}" != "${FGROUP}" ]]; then
        echo "${FGROUP}" > "$tname"
        echo -e "[${FGROUP}]"
    fi
}

function info() {
    if [[ ${VERBOSE} ]]; then
        show_group
        echo -e "${@}"
    fi
    return 0
}

function warn() {
    show_group
    echo -e "${@}"
    return 0
}


function rcopy() {
    local SRC="${1/\~/$HOME}"
    local DST="${2/\~/$HOME}"
    local md5src md5dst

    if [[ ! -e "$SRC" ]]; then
        warn "    - path \033[31m${SRC/$HOME/\~}\033[0m not exists"
        return 0
    fi

    if [[ -d "$SRC" ]]; then
        ls -al -b "$SRC/" | while read -a item; do {
            item="${item[8]}"

            if [[ "$item" && "$item" != "." && "$item" != ".." ]]; then
                rcopy "$SRC/${item}" "$DST/${item}"
            fi
        } done
        return 0
    fi

    md5src=$(md5sum "$SRC" 2>/dev/null | awk '{ print $1 }')
    md5dst=$(md5sum "$DST" 2>/dev/null | awk '{ print $1 }')

    [[ ${FORCE} ]] && md5dst=

    if [[ "${md5src}" != "${md5dst}" ]]; then
        info "    - path \033[33m${SRC/$HOME/\~}\033[0m was need to copy"

        if [[ ! ${DRY_RUN} ]]; then
            mkdir -p "$(dirname "$DST")" > /dev/null 2>&1

            cp -xarf "$SRC" "$DST" \
                && warn "    + file \033[32m${SRC/$HOME/\~}\033[0m is copied" \
                || warn "    - file \033[31m${SRC/$HOME/\~}\033[0m is not copied!"
        fi
    else
        info "    - path \033[34m${SRC/$HOME/\~}\033[0m not modified"
    fi
}


function rdconf() {
    local path="${1/\~/$HOME}"
    local base="$(basename $path)"
    local md5src md5dst

    dconf dump "/${base//./\/}/" > "/tmp/$base"

    md5src=$(md5sum "/tmp/$base" 2>/dev/null | awk '{ print $1 }')
    md5dst=$(md5sum "$path"      2>/dev/null | awk '{ print $1 }')

    [[ ${FORCE} ]] && md5dst=

    if [[ "${md5src}" != "${md5dst}" ]]; then
        info "    - dconf \033[33m${base}\033[0m was need to copy"

        if [[ ! ${DRY_RUN} ]]; then
            if [[ ${RESTOTE} ]]; then
                dconf load "/${base//./\/}/" < "$path" \
                    && warn "    + dconf \033[32m${base}\033[0m is loaded" \
                    || warn "    - dconf \033[31m${base}\033[0m is not loaded!"
            else
                mkdir -p "$(dirname "$path")" > /dev/null 2>&1

                cp -xarf "/tmp/$base" "$path" \
                    && warn "    + dconf \033[32m${base}\033[0m is dumped" \
                    || warn "    - dconf \033[31m${base}\033[0m is not dumped!"
            fi
        fi
    else
        info "    - dconf \033[34m${base}\033[0m not modified"
    fi

    rm -f "/tmp/$base" 2>/dev/null
}


while [ -n "$1" ]; do
    case "${1}" in
    --backup|-b)
        MODE="Backup"
        RESTOTE=
        ;;
    --restore|-r)
        MODE="Restore"
        RESTOTE=true
        ;;
    --dry-run|-d)
        DRY_RUN=true
        VERBOSE=true
        ;;
    --verbose|-v)
        VERBOSE=true
        ;;
    --force|-f)
        FORCE=true
        ;;
    --help)
        exit 0
        ;;
    *)
        if [[ ${1:0:1} == "-" ]]; then
            echo -e "\033[31mInvalid parametr '${1}'\033[0m" >&2
            exit 1
        fi
            
        BACKUP_GROUPS["$1"]=true
        ;;
    esac
    shift
done


echo -e "\033[33m-- ${MODE:-Backup} started --\033[0m"


for f in *.list; do
    echo -e "** $f"
    STORAGE="${f%%.*}"

    while IFS= read -r line; do
        line="$(echo "$line" | sed -e 's/^[[:space:]]*//')"

        [[ ! "$line" ]] && continue
        [[ "${line:0:1}" == "#" ]] && continue

        if [[ "${line:0:1}" == "[" ]]; then
            size=$(( ${#line} - 2 ))
            FGROUP="${line:1:$size}"
            continue
        fi

        if [[ ${#BACKUP_GROUPS[@]} -gt 0 ]]; then
            [[ ${BACKUP_GROUPS["${FGROUP}"]} ]] 2>/dev/null || continue
        fi

        if [[ "${FGROUP}" == "dconf" ]]; then
            rdconf "${STORAGE:-data}/.dconf/$line"
            continue
        fi

        point="${line/\~/${STORAGE:-data}}"
        point="${point/$HOME/${STORAGE:-data}}"

        if [[ ${RESTOTE} ]]; then
            rcopy "$point" "$line"
        else
            rcopy "$line" "$point"
        fi

    done < "$f"
done


[[ -e ".git" && ! "${DRY_RUN}" ]] \
    && echo "" \
    && git status


DIFF=$((`date '+%s'` - $DIFF))
echo -e "\033[32m-- ${MODE:-Backup} completed with $(displaytime $DIFF) --\033[0m"
