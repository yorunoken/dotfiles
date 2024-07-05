#!/usr/bin/env bash

#	originally written by: gh0stzk - https://github.com/gh0stzk/dotfiles
#	rewritten for hyprland by :	 develcooking - https://github.com/develcooking/hyprland-dotfiles
#	Info    - This script runs the rofi launcher, to select
#             the wallpapers included in the theme you are in.

dir="$HOME/.config/rofi"
theme='grid'

# Set some variables
wall_dir="${HOME}/Pictures/Wallpapers"
cacheDir="${HOME}/.cache/thumbnails-wallpaper"
rofi_command="rofi -x11 -dmenu -theme ${dir}/${theme}"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ]; then
    mkdir -p "${cacheDir}"
fi

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
	if [ -f "$imagen" ]; then
		nombre_archivo=$(basename "$imagen")
		if [ ! -f "${cacheDir}/${nombre_archivo}" ] ; then
			magick convert -strip "$imagen" -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"
		fi
    fi
done

# Select a picture with rofi
wall_selection=$(find "${wall_dir}"  -maxdepth 1  -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A ; do  echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n" ; done | $rofi_command)

echo $wall_selection
