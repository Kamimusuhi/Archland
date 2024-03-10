#!/bin/bash

if [ ! -d "$HOME/Archland" ]; then
    echo "Please clone the repository into your home directory."
    exit 1
fi

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
    sudo pacman -S --noconfirm linux-headers nvidia-dkms nvidia-utils nvidia-settings 
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

yes | sudo pacman -S --noconfirm atuin bat dust yazi swaybg ffmpegthumbnailer unarchiver jq poppler fd ripgrep fzf tree bash zoxide neovim nwg-look pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-media-session ttf-jetbrains-mono-nerd noto-fonts-emoji noto-fonts-cjk polkit-gnome mpv imv ffmpeg hyprland  dunst wofi grim slurp kitty imagemagick pavucontrol pamixer brightnessctl waybar xdg-desktop-portal-hyprland cliphist bluez bluez-utils pulseaudio-bluetooth gvfs-mtp btop noto-fonts libsixel wlsunset cowsay

dirtheme="/usr/share/themes/"
if [ ! -d "$dirtheme" ]; then
    sudo mkdir -p "$dirtheme"
fi
sudo cp -r $HOME/Archland/.files/.themes/* $dirtheme

sudo cp -r $HOME/Archland/.files/.fonts/Geist.Mono/* /usr/share/fonts/
fc-cache -f -v

sudo cp $HOME/Archland/.files/.issue/issue /etc/issue

if [ ! -d "$HOME/.config/" ]; then
    mkdir -p "$HOME/.config/"
fi
cp -R $HOME/Archland/.files/.config/* $HOME/.config/

cp $HOME/Archland/.files/.bash/.bash_profile $HOME/
cp $HOME/Archland/.files/.bash/.bashrc $HOME/

mkdir -p $HOME/Pictures/Screenshots/
mkdir -p $HOME/.local/share/vocab/
cp $HOME/Archland/.files/.bash/vocabulary.txt $HOME/.local/share/vocab/

sudo systemctl enable --now bluetooth
sudo sed -i 's/^Exec=nvim %F/Exec=kitty nvim %F/; s/Terminal=true/Terminal=false/' /usr/share/applications/nvim.desktop
sudo sed -i 's/^Exec=yazi %u/Exec=kitty yazi %u/; s/Terminal=true/Terminal=false/' /usr/share/applications/yazi.desktop

read -p "Do you want to install additional packages? (Y/n): " choice
choice=$(echo "${choice:-Y}" | tr '[:lower:]' '[:upper:]')  # Default to Y if no input is provided
if [[ "$choice" == "Y" ]]; then
    chmod +x .files/.extras/extra.sh && (cd .files/.extras/ && ./extra.sh)
else
    echo "No additional packages will be installed."
fi


Hyprland
