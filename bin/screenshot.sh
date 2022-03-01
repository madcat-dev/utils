#!/usr/bin/env bash

WELCOME=$(cat <<- ENDWELCOME
███████  ██████ ██████  ███████ ███████ ███    ██ ███████ ██   ██  ██████  ████████ 
██      ██      ██   ██ ██      ██      ████   ██ ██      ██   ██ ██    ██    ██    
███████ ██      ██████  █████   █████   ██ ██  ██ ███████ ███████ ██    ██    ██    
     ██ ██      ██   ██ ██      ██      ██  ██ ██      ██ ██   ██ ██    ██    ██    
███████  ██████ ██   ██ ███████ ███████ ██   ████ ███████ ██   ██  ██████     ██   
ENDWELCOME
)

send_notification() {
    notify-send -u NORMAL \
        -i "$SAVE_PATH" \
        "${SAVE_PATH/$HOME/\~}"
}

SAVE_PATH="$(mktemp -u "$(xdg-user-dir DESKTOP)/$(date +'%Y-%m-%d').XXXXXX.png")"

case "${1}" in
    -f|full)
        CMD="-f"
        ;;
    -w|win)
        CMD="-w"
        ;;
    -r|region)
        CMD="-r"
        ;;
    *)
        echo -e "$WELCOME"
        exit 1
        ;;
esac

xfce4-screenshooter ${CMD/_/} -s "$SAVE_PATH" \
    && send_notification
