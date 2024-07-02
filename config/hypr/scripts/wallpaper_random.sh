#!/bin/bash

# hyprpaper

WALLPAPER_PATH="$HOME/Pictures/Wallpapers/"

RANDOM_WALLPAPER=$(find "$WALLPAPER_PATH" -type f | shuf -n 1)

echo "Selected random wallpaper: $RANDOM_WALLPAPER"

hyprctl hyprpaper preload "$RANDOM_WALLPAPER"
hyprctl hyprpaper wallpaper "DP-1,$RANDOM_WALLPAPER"
hyprctl hyprpaper wallpaper "DP-3,$RANDOM_WALLPAPER"
hyprctl hyprpaper splash "true"
# sh "$HOME/.config/hypr/scripts/gamemode.sh"
