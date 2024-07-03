#!/usr/bin/env bash
cd "$(dirname "$0")"
export base="$(pwd)"

source ./scripts/environment-variables
source ./scripts/functions
source ./scripts/installers

if ! command -v pacman >/dev/null 2>&1;then printf "\e[31m[$0]: pacman not found. It seems that the system is not Arch Linux or Arch-based distros. Aborting...\e[0m\n";exit 1;fi

startask() {
    printf "\e[34m[$0]: Hi there! Before we start:\n"
    printf 'This script 1. only works for Arch Linux and Arch-based distros.\n'
    printf '            2. does not handle system-level/hardware stuff like Nvidia drivers\n'
    printf "\e[31m"
    printf "Please CONFIRM that you HAVE ALREADY BACKED UP \"$XDG_CONFIG_HOME\" and \"$HOME/.local/\" folders!\n"
    printf "\e[0m"
    printf "Enter capital \"YES\" (without quotes) to continue:"
    read -p " " p
    case $p in "YES")sleep 0;; *)echo "Received \"$p\", aborting...";exit 1;;esac
    printf '\n'
    printf 'Do you want to confirm every time before a command executes?\n'
    printf '  y = Yes, ask me before executing each of them. (DEFAULT)\n'
    printf '  n = No, just execute them automatically.\n'
    printf '  a = Abort.\n'
    read -p "====> " p
    case $p in
        n)ask=false;;
        a)exit 1;;
        *)ask=true;;
    esac
}

case $ask in
    false)sleep 0;;
    *)startask ;;
esac

set -e
#####################################################################################
printf "\e[36m[$0]: 1. Get packages\n\e[0m"


if ! command -v yay >/dev/null 2>&1;then
    echo -e "\e[33m[$0]: \"yay\" not found, installing...\e[0m"
  showfun install-yay
  v install-yay
fi

$ask || sudo pacman -S hyprland

$ask || sudo pacman -S kitty

$ask || yay -S catnap-git

$ask || yay -S yazi

$ask || yay -S vesktop

$ask || yay -S visual-studio-code-bin

$ask || yay -S librewolf-bin

$ask || sudo pacman -S waybar

$ask || sudo pacman -S rofi

$ask || sudo pacman -S hyprlock

# enable the services after, todo
$ask || sudo pacman -S sddm

$ask || sudo yay -S ncspot-git

# fonts
$ask || yay -S ttf-material-design-icons-desktop-git nerd-fonts-git cantarell-static-fonts ttf-hackgen

# todo: copy config files from here to $XDG_CONFIG_HOME
