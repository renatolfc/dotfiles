#!/bin/sh

case "$1" in
    suspend)
        zenity --question --text="Are you sure you want to suspend?"
        if [ "$?" = "0" ]; then
            xscreensaver-command -lock
            systemctl suspend
        fi
        ;;
    hibernate)
        zenity --question --text="Are you sure you want to hibernate?"
        if [ "$?" = "0" ]; then
            xscreensaver-command -lock
            systemctl hybrid-sleep
        fi
        ;;
    reboot)
        zenity --question --text="Are you sure you want to reboot?"
        if [ "$?" = "0" ]; then
            systemctl reboot
        fi
        ;;
    poweroff)
        zenity --question --text="Are you sure you want to power off?"
        if [ "$?" = "0" ]; then
            systemctl poweroff
        fi
        ;;
    *)
        echo "Usage: $0 {suspend|hibernate|reboot|poweroff}"
        ;;
esac

