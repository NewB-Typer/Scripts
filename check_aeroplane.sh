#!/bin/bash

# Initialize a variable to track the airplane mode status
airplane_mode="no"

# Loop through each Wireless LAN entry to check if any are blocked
while read -r line; do
    if echo "$line" | grep -q "Wireless LAN"; then
        # Read the next line which contains the status
        read -r next_line
        if echo "$next_line" | grep -q "Soft blocked: yes"; then
            airplane_mode="yes"
            break
        fi
    fi
done < <(rfkill list all)

# Output the status based on the airplane_mode variable
if [[ "$airplane_mode" == "yes" ]]; then
    echo "Airplane mode enabled"
else
    echo "Airplane mode disabled"
fi
