#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <minutes>"
    exit 1
}

# Check if input is provided
if [ "$#" -ne 1 ]; then
    usage
fi

# Get the input minutes and convert to seconds
minutes=$1
if ! [[ "$minutes" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number of minutes."
    exit 1
fi

seconds=$((minutes * 60))

# Countdown loop
while [ $seconds -gt 0 ]; do
    echo -ne "Time left: $((seconds / 60))m $((seconds % 60))s\033[0K\r"
    sleep 1
    seconds=$((seconds - 1))
done

echo -ne "Time's up!         \n"
