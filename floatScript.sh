#!/usr/bin/env bash

# Path to Polybar configuration
CONFIG_PATH="$HOME/.config/polybar/config.ini"

# Desktop ID for floating mode
FLOATING_DESKTOP_ID=$(bspc query -D -d '^4')

# Function to update Polybar dim value
update_polybar_config() {
    if [ "$FLOATING_DESKTOP_ID" = "$(bspc query -D -d ^4)" ]; then
        # Change dim value to 0.1
        sed -i 's/^dim = .*/dim = 0.1/' "$CONFIG_PATH"
    else
        # Revert dim value to default (e.g., 0.5)
        sed -i 's/^dim = .*/dim = 0.5/' "$CONFIG_PATH"
    fi

    # Restart Polybar
    pkill -x polybar
    polybar mybar &
}

# Initial check
update_polybar_config

# Watch for new nodes and update if necessary
bspc subscribe node_add | while read -a msg ; do
    desk_id=${msg[2]}
    wid=${msg[4]}
    if [ "$FLOATING_DESKTOP_ID" = "$desk_id" ]; then
        bspc node "$wid" -t floating
        update_polybar_config
    fi
done
