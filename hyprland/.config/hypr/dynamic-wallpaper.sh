#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"

while true; do
    CURRENT_WALL=$(hyprctl hyprpaper listloaded)

    # Get a random wallpaper that is not the current one
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

    # Apply the selected wallpaper
    hyprctl hyprpaper reload ,"$WALLPAPER"

    # Wait for 5 minutes (300 seconds)
    sleep 300
done
