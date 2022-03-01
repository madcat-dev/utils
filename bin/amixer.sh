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

    [[ $volume -gt 30 ]] && level=NORMAL   && icon=
    [[ $volume -ge 50 ]] && level=LOW      && icon=
    [[ $volume -ge 70 ]] && level=CRITICAL && icon= 

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
            amixer -q set Master 5%+
            send_notification
        fi
        ;;
    down)
        if [[ $volume != "muted" ]] ; then
            amixer -q set Master 5%-
            send_notification
        fi
        ;;
    toggle)
        amixer -q set Master toggle
        send_notification
        ;;
    *)
        echo -e "$WELCOME"
        ;;
esac
