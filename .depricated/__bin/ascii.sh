#!/usr/bin/env bash

WIDTH=72
SCALE='2.7'

FONT="Iosevka Fixed Curly Medium"
FONT_SIZE=72

CHARS='`.,-~+=^*/":;!&$#@'

while [ -n "$1" ]; do
    case "${1}" in
    --width)
        WIDTH="${2}"
        shift
        ;;

    --scale)
        SCALE="${2}"
        shift
        ;;

    --chars)
        CHARS="${2}"
        shift
        ;;

    --reverse)
        REVERSE=True
        ;;

    --alt)
        CHARS='░▒▓█'
        ;;

    --ascii)
        ASCII=True
        ;;

    --font)
        if [[ "${2}" == "list" ]]; then
            convert -list font
            exit 0
        fi
        FONT="${2}"
        shift
        ;;

    --font-size)
        FONT_SIZE="${2}"
        shift
        ;;

    --text)
        IMG=$(mktemp /tmp/image-XXXXXXXX.png)
        RM_IMG="$IMG"
        convert -background black -fill white \
            -font "${FONT//\ /-}" -pointsize ${FONT_SIZE} \
            label:"${2}" \
            $IMG
        shift
        ;;

    *)
        IMG="${1}"
        ;;
    esac
    shift
done

if [[ ! "${IMG}" ]]; then
    # Usage
    exit 0
fi


SIZE=( $(identify -ping -format '%w %h' "$IMG") )
HEIGHT=$( echo "scale = 0; ${SIZE[1]} * $WIDTH / ${SIZE[0]} / ${SCALE}" | bc -l )
BIT=$( echo "scale = 0; 255 / (${#CHARS} + 1)" | bc -l )
[[ $BIT -le 0 ]] && BIT=1


TMP_IMG=$(mktemp /tmp/image-XXXXXXXX.png)

convert "$IMG" \
    -resize ${WIDTH}x${HEIGHT}! +dither \
    -colorspace Gray \
    -colors 256 \
    "$TMP_IMG"

echo "Size: ${WIDTH}x${HEIGHT}, ${#CHARS}, $BIT"

draw_bit() {
    local i
    local v="${1:-0}"

    i=$(( $v / $BIT ))

    if [[ $i -le 0 ]]; then
        echo -n " "
    else
        [[ $i -gt ${#CHARS} ]] && i=${#CHARS}
        i=$(( $i - 1 ))
        echo -n "${CHARS:$i:1}"
    fi
}

draw_bit_ascii() {
    local v=$(( ${1:-0} / 2 ))

    [[ $v -gt 126 ]] && v=126
    [[ $v -lt 32 ]]  && v=32
    echo -en "$(printf '\\x%02X' $v)"
}

while read -r V; do
    declare -i v

    if [[ ${index:-0} -eq $WIDTH ]]; then
        index=0
        echo ""
    fi
    ((index++))

    v=$(echo "$V" | awk '{print $NF}' | sed 's/[gray\(\)%]*//g')

    [[ "${REVERSE}" ]] \
        && v=$(( 255 - $v ))  # Reverse

    [[ "${ASCII}" ]] \
        && draw_bit_ascii $v \
        || draw_bit $v

done <<< $( convert "$TMP_IMG" txt: | grep 'gray(' )

echo ""

# Remove tmp-image files
rm -f "$TMP_IMG"

[[ "${RM_IMG}" ]] \
    && rm -f "$RM_IMG"
