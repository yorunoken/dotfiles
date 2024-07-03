if ! command -v pacman >/dev/null 2>&1;then printf "\e[31m[$0]: pacman not found. It seems that the system is not ArchLinux or Arch-based distros. Aborting...\e[0m\n";exit 1;fi
if ! command -v yay >/dev/null 2>&1;then printf "\e[31m[$0]: yay not found. Please install yay, an AUR helper before continuing. Aborting...\e[0m\n";exit 1;fi
prevent_sudo_or_root