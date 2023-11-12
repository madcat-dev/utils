#!/usr/bin/env bash
# requirements:
#   xinput (arch xorg-xinput package)

APPNAME="touchpad_notify"
CANNEL="Master"
ICON=

send_notification() {
    STATUS="disabled"
    LEVEL=CRITICAL

    if [[ $1 -eq 1 ]]; then
        STATUS="enabled"
        LEVEL=NORMAL
    fi

    NOTIFY="$ICON Touchpad: ${STATUS}"

    echo "$NOTIFY"

    notify-send -u $LEVEL \
        -h string:x-canonical-private-synchronous:$APPNAME \
        -t 2000 \
        "$NOTIFY"
}

get_status() {
    xinput list-props "$1" | grep "Device Enabled" | awk '{print $NF}'
}


if ! which xinput > /dev/null; then
    echo "xinput not found!"
    exit 1
fi

ID=$(xinput | grep "Touchpad" | tail -n 1 | sed 's/^.*id=//' | awk '{print $1}')

[[ ! "$ID" ]] && exit 0

case "${1^^}" in
    TOGGLE)
        [[ $(get_status "$ID") -eq 1 ]] \
            && xinput disable "$ID" \
            || xinput enable "$ID"
        ;;
    ON)
        xinput enable "$ID"
        ;;
    OFF)
        xinput disable "$ID"
        ;;
    *)
        ;;
esac

send_notification $(get_status "$ID")
