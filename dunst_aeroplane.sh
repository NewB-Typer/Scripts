#!/bin/bash

# Call the updated status check script
status=$(bash $HOME/CS/check_aeroplane.sh)
icon=$HOME/.config/dunst/icons/aeroplane.png

# Display the notification based on the status
if [[ "$status" == "Airplane mode enabled" ]]; then
    dunstify -u normal -i $icon "Airplane Mode Enabled" 
elif [[ "$status" == "Airplane mode disabled" ]]; then
    dunstify -u normal -i $icon "Airplane Mode Disabled" 
else
    dunstify -u normal -i $icon "Airplane Mode Status Unknown"
fi
