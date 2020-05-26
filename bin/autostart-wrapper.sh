#!/bin/sh

AUTOSTART=$HOME/bin/autostart.sh
AUTOSTARTRUN=$HOME/.autostartrun

function autostart_stuff() {
    echo $DBUS_SESSION_BUS_ADDRESS > $AUTOSTARTRUN
    $AUTOSTART
}

if [ ! -x $AUTOSTART ]; then
    exit 1
fi

if [ ! -f "$AUTOSTARTRUN" ]; then
    # autostart has never been run, run it
    autostart_stuff
else
    current_session=$(echo $DBUS_SESSION_BUS_ADDRESS)
    last_session=$(cat $AUTOSTARTRUN)
    if [ "$current_session" != "$last_session" ]; then
        # autostart has been run, but in a previous session
        autostart_stuff
    fi
fi

