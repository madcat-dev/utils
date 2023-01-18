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
    SPATH=${1:-$SAVE_PATH}

    notify-send -u NORMAL \
        -i "$SAVE_PATH" \
        "${SPATH/$HOME/\~}"
}

if ! which xfce4-screenshooter > /dev/null; then
    echo -e "$WELCOME"
    echo -e "\033[31mxfce4-screenshooter not found\033[0m"
    exit 1
fi

SAVE_PATH="$(xdg-user-dir DESKTOP)/$(date +'%Y-%m-%d').$(printf "%05x" `date +%H%M%S`).png"

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
        exit 0
        ;;
esac

if xfce4-screenshooter ${CMD/_/} -s "$SAVE_PATH"; then
    if [[ "${2}" == "--clip" ]]; then
        if which xclip > /dev/null; then
            xclip -selection clipboard -t image/png -i "$SAVE_PATH"
            send_notification "Clipboard"
            rm -f "$SAVE_PATH"
            exit 0
        fi
    fi

    send_notification
fi
