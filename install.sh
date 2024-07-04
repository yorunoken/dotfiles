#!/usr/bin/env bash
cd "$(dirname "$0")"
export base="$(pwd)"

# get config folder
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
 
# prevent sudo
case $(whoami) in
    root)echo -e "\e[31m[$0]: This script is NOT to be executed with sudo or as root. Aborting...\e[0m";exit 1;;
esac

if ! command -v pacman >/dev/null 2>&1; then 
    printf "\e[31m[$0]: pacman not found. It seems that the system is not Arch Linux or Arch-based. Aborting...\e[0m\n"
    exit 1
fi

startask() {
    printf "\e[34m[$0]: Hi there! Before we start:\n"
    printf 'This script 1. only works for Arch Linux and Arch-based distros.\n'
    printf '            2. does not handle system-level/hardware stuff like Nvidia drivers\n'
    printf "\e[31m"
    printf "Please CONFIRM that you HAVE ALREADY BACKED UP \"$XDG_CONFIG_HOME\" and \"$HOME/.local/\" folders!\n"
    printf "\e[0m"
    printf "Enter capital \"YES\" (without quotes) to continue:"
    read -p " " p
        case $p in 
        "YES") sleep 0 ;;
        *) echo "Received \"$p\", aborting..."; exit 1 ;;
    esac

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

install_package() {
    if $ask; then
        read -p "Do you want to install $1? (Y/n) (press a to execute the rest automatically) " response
        response=${response:-Y}
        case $response in
            [yY][eE][sS]|[yY]*) sudo pacman -S $1 --noconfirm ;;
            [aA]*) $ask = false; install_package $1 ;;
            *) printf "\e[33mSkipping $1...\e[0m\n" ;;
        esac
    else
        sudo pacman -S $1
    fi
}

install_yay_package() {
    if $ask; then
        read -p "Do you want to install $1 from AUR? (Y/n) (press a to execute the rest automatically) " response
        response=${response:-Y}
        case $response in
            [yY][eE][sS]|[yY]*) yay -S $1 --noconfirm ;;
            [aA]*) $ask = false; install_yay_package $1 ;;
            *) printf "\e[33mSkipping $1...\e[0m\n" ;;
        esac
    else
        yay -S $1
    fi
}

if ! command -v yay >/dev/null 2>&1;then
    echo -e "\e[33m[$0]: \"yay\" not found, installing...\e[0m"
    sudo pacman -S --needed --noconfirm base-devel
    git clone https://aur.archlinux.org/yay-bin.git /tmp/buildyay
    cd /tmp/buildyay
    makepkg -si --noconfirm
    cd $base
    rm -rf /tmp/buildyay
fi

install_package hyprland
install_yay_package hyprpicker-git
install_package kitty
install_yay_package catnap-git
install_yay_package yazi
install_yay_package vesktop
install_yay_package visual-studio-code-bin
install_yay_package librewolf-bin
install_package waybar
install_package rofi
install_package hyprlock
install_package sddm
install_yay_package ncspot-git
install_yay_package ttf-material-design-icons-desktop-git
install_yay_package nerd-fonts-git
install_yay_package cantarell-static-fonts
install_yay_package ttf-hackgen

set -e
#####################################################################################
printf "\e[36m[$0]: 2. Copy Config files\n\e[0m"

read -p "\e[1;31m Please confirm that you have backed up \"$XDG_CONFIG_HOME\" folder once again. This action will configure your config files. (y/N) \e[0m" response
case $response in
    [yY]*) 
        mkdir -p "$XDG_CONFIG_HOME" 

        for dir in ./config/*; do
            if [ -d "$dir" ]; then
                dir_name=$(basename "$dir")
                mkdir -p "$XDG_CONFIG_HOME/$dir_name"
                cp -r "$dir"/* "$XDG_CONFIG_HOME/$dir_name/"
            fi
        done 

        printf "\e[32mFolders copied successfully to $XDG_CONFIG_HOME.\e[0m\n"       
        ;;
    *) 
        printf "\e[33mExiting...\e[0m\n"; 
        exit 1 
        ;;
esac

# Enable SDDM service
sudo systemctl enable sddm

printf "\e[42m Setup has been completed. Restart your computer and log into Hyprland.\nIf you come across any issues, message @yorunoken on Discord."