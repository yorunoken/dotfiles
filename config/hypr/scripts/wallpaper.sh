#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments provided."
    exit 1
fi

WALLPAPER_PATH="$HOME/Pictures/Wallpapers/"
case $1 in
    random)

        RANDOM_WALLPAPER=$(find "$WALLPAPER_PATH" -type f | shuf -n 1)

        echo "Selected random wallpaper: $RANDOM_WALLPAPER"

        hyprctl hyprpaper preload "$RANDOM_WALLPAPER"
        hyprctl hyprpaper wallpaper "DP-1,$RANDOM_WALLPAPER"
        hyprctl hyprpaper wallpaper "DP-2,$RANDOM_WALLPAPER"
        hyprctl hyprpaper splash "true"
        exit 1
        ;;

    select)
        SELECTED_WALLPAPER=$(find "$WALLPAPER_PATH" -type f | sh ~/.config/rofi/wallpaper/wallpaper.sh)

        hyprctl hyprpaper preload "${WALLPAPER_PATH}${SELECTED_WALLPAPER}"
        hyprctl hyprpaper wallpaper "DP-1,${WALLPAPER_PATH}${SELECTED_WALLPAPER}"
        hyprctl hyprpaper wallpaper "DP-2,${WALLPAPER_PATH}${SELECTED_WALLPAPER}"
        hyprctl hyprpaper splash "true"
        exit 1
        ;;
    *)
        echo "Unknown argument: $1"
        exit 1
        ;;
esac

