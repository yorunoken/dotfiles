#!/usr/bin/env bash

WALLPAPER_DIR=~/Pictures/Wallpapers

wallpapers=$(ls "$WALLPAPER_DIR")
selected=$(echo "$wallpapers" | wofi --dmenu --prompt="Select Wallpaper" -w 2)
echo $selected
