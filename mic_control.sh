#!/bin/bash

# Toggle microphone mute state using pactl
pactl set-source-mute @DEFAULT_SOURCE@ toggle > /dev/null

# Check the current state of the microphone
MUTED=$(pactl list sources | grep -A 10 'State: ' | grep -q 'Mute: yes')
if [ $? -eq 0 ]; then
    # Microphone is muted
    ICON="$HOME/.config/dunst/icons/mic_mute.png"
    MESSAGE="Microphone muted"
else
    # Microphone is unmuted
    ICON="$HOME/.config/dunst/icons/mic_unmute.png"
    MESSAGE="Microphone unmuted"
fi

# Display notification using dunst
dunstify -i $ICON "$MESSAGE" -r 2593 -t 1500

