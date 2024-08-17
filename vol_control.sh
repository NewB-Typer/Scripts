#!/bin/bash

case "$1" in
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        ;;
    *)
        echo "Usage: $0 {mute|up|down}"
        exit 1
        ;;
esac

# Get current volume percentage
volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
mute=$(pactl list sinks | grep 'Mute:' | head -n 1 | awk '{print $2}')

# Send notification
if [ "$mute" = "yes" ]; then
    dunstify -a "Volume" -i "$HOME/.config/dunst/icons/mute.png" -u low -r 2593 "Volume muted" -t 2000
else
    dunstify -a "Volume" -i "$HOME/.config/dunst/icons/volume.png" -u low -r 2593 "Volume: $volume%" -t 2000
fi
