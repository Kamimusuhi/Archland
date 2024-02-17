#!/bin/bash

if [ -f /etc/os-release ] && grep -q '^ID=\(arch\|.*arch\)' /etc/os-release; then
  echo " "
else
  echo "This script is intended for Arch Linux or Arch-based distributions only."
  exit 1
fi

sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15\nILoveCandy/" /etc/pacman.conf

sudo pacman -Sy --noconfirm libnewt

# Check if NVIDIA GPU is present
if lspci | grep -i nvidia > /dev/null; then
    echo "NVIDIA GPU detected. Installing nvidia-dkms and nvidia-utils..."
    sudo pacman -S --noconfirm nvidia-dkms nvidia-utils
    echo "nvidia-dkms and nvidia-utils installed successfully."
else
    echo "No NVIDIA GPU detected."
fi

ISAUR=/sbin/paru
if [ -f "$ISAUR" ]; then 
    echo -e "Paru was located, moving on.\n"   
else
    echo "Installing Paru for a AUR Helper"
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin && makepkg -si

fi

yes | sudo pacman -S --noconfirm yazi ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf tree bash zoxide neovim nwg-look pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-media-session ttf-jetbrains-mono-nerd noto-fonts-emoji noto-fonts-cjk polkit-gnome mpv imv ffmpeg hyprland  dunst wofi swaybg grim slurp kitty imagemagick pamixer brightnessctl waybar xdg-desktop-portal-hyprland cliphist bluez bluez-utils pulseaudio-bluetooth gvfs-mtp btop noto-fonts libsixel wlsunset cowsay 

sudo cp -R .files/.themes/* /usr/share/themes/
sudo cp .files/.issue/issue /etc/issue
cp -R .files/.config/* ~/.config/

sudo systemctl enable --now bluetooth
sudo sed -i 's/^Exec=nvim %F/Exec=kitty nvim %F/; s/Terminal=true/Terminal=false/' /usr/share/applications/nvim.desktop


