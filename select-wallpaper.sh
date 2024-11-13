#!/usr/bin/env bash
# Define directories
dir1="$HOME/Steal/Wall_is/Download"
dir2="$HOME/Steal/Wall_is/PC-Walli"
dir3="$HOME/Steal/Wall-is/Pics"

# Select a wallpaper using wofi
NEW_WALL=$(find "$dir1" "$dir2" "$dir3" -type f | wofi --dmenu --allow-images true)

# Check if a wallpaper was selected
if [ -n "$NEW_WALL" ]; then
    # Update the Hyprland wallpaper configuration
    echo '' > ~/.config/hypr/hyprpaper.conf
    echo "preload = $NEW_WALL" >> ~/.config/hypr/hyprpaper.conf
    echo "wallpaper =,$NEW_WALL" >> ~/.config/hypr/hyprpaper.conf

    # Copy the wallpaper to the cache
    cp -rf "$NEW_WALL" ~/.cache/current_wallpaper

rm -rf ~/.config/waybar/colors-waybar.css

wal -i ~/.cache/current_wallpaper


cp ~/.cache/wal/colors-waybar.css ~/.config/waybar
echo  "Generating Waybar css"
    # Reload Hyprland configuration
 pkill hyprpaper

hyprpaper &


    echo "Wallpaper set successfully."
else
    echo "Setting Wallpaper Failed!!!"
fi
