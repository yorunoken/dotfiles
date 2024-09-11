#!/usr/bin/env bash

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"

# Options
shutdown='󰐥'
reboot=''
lock='󰌾'
suspend='󰒲'
logout='󰍃'
# yes=''
# no=''

# Wofi CMD
wofi_cmd() {
    wofi --dmenu \
        --prompt "Uptime: $uptime" \
        --location center \
        -s ~/.config/wofi/modules/powermenu/style.css \
        -c ~/.config/wofi/modules/powermenu/config
}

# Pass variables to wofi dmenu
run_wofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | wofi_cmd
}

# Execute Command
run_cmd() {
	if [[ $1 == '--shutdown' ]]; then
		systemctl poweroff
	elif [[ $1 == '--reboot' ]]; then
		systemctl reboot
	elif [[ $1 == '--suspend' ]]; then
		mpc -q pause
		amixer set Master mute
		systemctl suspend
	elif [[ $1 == '--logout' ]]; then
		if [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
			openbox --exit
		elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
			bspc quit
		elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
			i3-msg exit
		elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
			qdbus org.kde.ksmserver /KSMServer logout 0 0 0
		elif [[ "$DESKTOP_SESSION" == "xfce" ]]; then
			killall xfce4-session
		elif [[ "$DESKTOP_SESSION" == "hyprland" ]]; then
			killall Hyprland
		fi
	fi

}

# Actions
chosen="$(run_wofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		hyprlock
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
