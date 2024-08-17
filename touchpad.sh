#!/bin/bash

# Get the touchpad device ID
TOUCHPAD_ID=$(xinput list | grep -i 'touchpad' | awk '{print $6}' | sed 's/id=//')

# Check if the touchpad is currently enabled or disabled
TOUCHPAD_ENABLED=$(xinput list-props $TOUCHPAD_ID | grep "Device Enabled" | awk '{print $4}')

# Toggle the touchpad state based on the key symbol
if [ "$1" == "XF86TouchpadOff" ]; then
    # Toggle to disable touchpad
    xinput disable $TOUCHPAD_ID
    ICON="$HOME/.config/dunst/icons/touchpad_disabled.png"
    MESSAGE="Touchpad disabled"
elif [ "$1" == "XF86TouchpadOn" ]; then
    # Toggle to enable touchpad
    xinput enable $TOUCHPAD_ID
    ICON="$HOME/.config/dunst/icons/touchpad_enabled.png"
    MESSAGE="Touchpad enabled"
else
    echo "Unknown key symbol: $1"
    exit 1
fi

# Display notification using dunst
dunstify -i $ICON "$MESSAGE" -r 2593 -t 1500
