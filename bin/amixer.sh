#!/usr/bin/env bash

WELCOME=$(cat <<- ENDWELCOME
██    ██  ██████  ██      ██    ██ ███    ███ ███████ 
██    ██ ██    ██ ██      ██    ██ ████  ████ ██      
██    ██ ██    ██ ██      ██    ██ ██ ████ ██ █████   
 ██  ██  ██    ██ ██      ██    ██ ██  ██  ██ ██      
  ████    ██████  ███████  ██████  ██      ██ ███████ 
ENDWELCOME
)

APPNAME="volume_notify"
CANNEL="Master"

send_notification() {
    local volume=$(get_volume)
    local level=NORMAL icon=

    if [[ $volume == "muted" ]] ; then
        notify-send -u CRITICAL \
            -h string:x-canonical-private-synchronous:$APPNAME \
            " $CANNEL chanel is Muted"
        return
    fi

    [[ $volume -gt 33 ]] && icon=
    [[ $volume -gt 66 ]] && icon= 
    [[ $volume -gt 52 ]] && level=LOW
    [[ $volume -gt 75 ]] && level=CRITICAL

    notify-send -u $level \
        -h string:x-canonical-private-synchronous:$APPNAME \
        -h int:value:$volume \
        -t 2000 \
        "$icon $CANNEL chanel: ${volume}%"
}

get_volume() {
    local VOL=($(
        amixer get "$CANNEL" | tr -d '[]' | grep "Playback.*%" | head -n1 \
            | awk '{print $(NF-1),$NF}'
    ))

    [[ ${VOL[1]} == 'on' ]] \
        && echo ${VOL[0]/\%/} \
        || echo "muted"
}

volume=$(get_volume)

case "${1}" in
    up)
        if [[ $volume != "muted" ]] ; then
            amixer -q set $CANNEL 5%+
            send_notification
        fi
        ;;
    down)
        if [[ $volume != "muted" ]] ; then
            amixer -q set $CANNEL 5%-
            send_notification
        fi
        ;;
    toggle)
        amixer -q set $CANNEL toggle
        send_notification
        ;;
    *)
        echo -e "$WELCOME"
        ;;
esac
