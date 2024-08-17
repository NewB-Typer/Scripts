#!/bin/bash

# Path to the brightness icon
ICON_PATH="$HOME/.config/dunst/icons/brightness.png"

# Adjust brightness using xbacklight (you can use other tools like brightnessctl if preferred)
if [ "$1" = "increase" ]; then
  xbacklight -inc 5
  BRIGHTNESS_CHANGE="Increased"
elif [ "$1" = "decrease" ]; then
  xbacklight -dec 5
  BRIGHTNESS_CHANGE="Decreased"
else
  echo "Usage: $0 {increase|decrease}"
  exit 1
fi

# Get the current brightness level
CURRENT_BRIGHTNESS=$(xbacklight -get | awk '{print int($1)}')

# Send the notification
dunstify -i "$ICON_PATH" -r 2593 "Brightness $BRIGHTNESS_CHANGE" "$CURRENT_BRIGHTNESS%" -t 2000
