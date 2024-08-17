#!/bin/bash

# Webcam device ID
WEBCAM_ID="174f:241a"

# Check if the webcam is currently enabled or disabled
WEBCAM_ENABLED=$(lsusb -t | grep "$WEBCAM_ID")

# Toggle the webcam state
if [ -z "$WEBCAM_ENABLED" ]; then
    # Webcam is currently disabled, so enable it
    echo "Enabling webcam..."
    sudo modprobe uvcvideo  # Replace with the appropriate command to enable your webcam
else
    # Webcam is currently enabled, so disable it
    echo "Disabling webcam..."
    sudo modprobe -r uvcvideo  # Replace with the appropriate command to disable your webcam
fi

# Display notification using dunst
if [ -z "$WEBCAM_ENABLED" ]; then
    ICON="$HOME/.config/dunst/icons/camera.png"
    MESSAGE="Webcam enabled"
else
    ICON="$HOME/.config/dunst/icons/camera_off.png"
    MESSAGE="Webcam disabled"
fi

dunstify -i "$ICON" "$MESSAGE" -r 2593 -t 1500
