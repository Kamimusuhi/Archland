#!/bin/bash

entries="   Shutdown\n 󰗼  Logout\n 󰍁  Lock\n 󰜉  Reboot"

selected=$(echo -e $entries | wofi --width 250 --height 192 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
shutdown)
	exec systemctl poweroff -i
	;;
logout)
	exec hyprctl dispatch exit 0
	;;
lock)
	exec hyprlock
	;;
reboot)
	if [ -d /boot/EFI/Microsoft ]; then
		reboot_entries=" 󰜉  Reboot\n 󰜉  Boot to Windows"
		reboot_selected=$(echo -e $reboot_entries | wofi --width 250 --height 140 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')
		case $reboot_selected in
		reboot)
			exec systemctl reboot
			;;
		boot)
			echo "YOUR PASSWORD HERE" | sudo -S efibootmgr -n 0000 && reboot
			;;
		esac
	else
		exec systemctl reboot
	fi
	;;
esac
