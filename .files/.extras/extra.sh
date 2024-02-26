#!/bin/bash

# Exporting NEWT_COLORS environment variable
export NEWT_COLORS="
root=,black
window=,black
shadow=,black
border=white,black
title=white,black
textbox=white,black
radiolist=white,black
label=white,black
checkbox=white,black
compactbutton=white,black
button=white,black"

# Function to display menu and get user selection
show_menu() {
    whiptail --title "Additional Configuration" --checklist --separate-output "Select the apps you want to download:" 20 60 14 \
    "Thunar (GUI File Manager)" "" on \
    "Swaylock effects" "" on \
    "Nicotine+ (Music-sharing Client)" "" off \
    "Signal Desktop" "" on \
    "Secrets (GUI Password Manager)" "" off \
    "Neovim Config" "" on \
    "qbittorrent" "" off \
    "Spotify" "" off \
    "Rust desk" "" off \
    "Chromium" "" off \
    "Thromium" "" off \
    "Floorp (What Firefox should be)" "" off \
    "Firefox" "" off \
    "Librewolf" "" on \
    "VS-Code (Microsoft)" "" off \
    "VS-Codium" "" off \
    "LibreOffice" "" off \
    "Thunderbird" "" off \
    "OBS Studio" "" off \
    "Okular (Document Viewer)" "" off \
    "Vencord (Discord client)" "" off 2>selected.txt
}

download_apps() {
    while IFS= read -r app; do
        case $app in
            "Neovim Config")
                echo "Ricing Neovim..."
                sudo pacman -S --noconfirm neovim libmagick npm lua51
                sudo luarocks --lua-version=5.1 install magick
                sudo npm install -g live-server
                ;;
            "Thunar (GUI File Manager)")
                echo "Installing Thunar..."
                sudo pacman -S --noconfirm thunar gvfs-mtp tumbler unzip file-roller android-tools xdg-user-dirs
                ;;
            "Swaylock effects")
                echo "Installing Swaylock"
                paru -S --noconfirm swaylock-effects-git
                ;;
            "Nicotine+ (Music-sharing Client)")
                echo "Installing Nicotine+..."
                sudo pacman -S --noconfirm nicotine+
                ;;
            "Signal Desktop")
                echo "Installing Signal Desktop..."
                sudo pacman -S --noconfirm signal-desktop
                ;;
            "Secrets (GUI Password Manager)")
                echo "Installing Secrets..."
                sudo pacman -S --noconfirm secrets
                ;;
            "qbittorrent")
                echo "Installing qBittorrent..."
                sudo pacman -S --noconfirm qbittorrent
                ;;
            "Spotify")
                echo "Installing Spotify..."
                paru -S --noconfirm spotify zenity
                ;;
            "Rust desk")
                echo "Installing Rust desk..."
                paru -S --noconfirm rustdesk-bin
                ;;
            "Chromium")
                echo "Installing Chromium..."
                sudo pacman -S --noconfirm chromium
                ;;
            "Thromium")
                echo "Installing Thromium..."
                paru -S --noconfirm thorium-browser-bin
                ;;
            "Floorp (What Firefox should be)")
                echo "Installing Floorp..."
                paru -S --noconfirm floorp-bin
                ;;
            "Firefox")
                echo "Installing Firefox..."
                sudo pacman -S --noconfirm firefox
                ;;
            "Librewolf")
                echo "Installing Librewolf..."
                paru -S --noconfirm librewolf-bin
                ;;
            "VS-Code (Microsoft)")
                echo "Installing VS-Code (Microsoft)..."
                paru -S --noconfirm visual-studio-code
                ;;
            "VS-Codium")
                echo "Installing VS-Codium..."
                paru -S --noconfirm vscodium-bin
                ;;
            "LibreOffice")
                echo "Installing LibreOffice..."
                sudo pacman -S --noconfirm libreoffice-fresh
                ;;
            "Thunderbird")
                echo "Installing Thunderbird..."
                sudo pacman -S --noconfirm thunderbird
                ;;
            "OBS Studio")
                echo "Installing OBS Studio..."
                sudo pacman -S --noconfirm obs-studio
                ;;
            "Okular (Document Viewer)")
                echo "Installing Okular..."
                sudo pacman -S --noconfirm okular
                ;;
            "Vencord (Discord client)")
                echo "Installing Vencord (Discord client)..."
                paru -S --noconfirm vesktop-bin
                ;;
            *)
                echo "Unknown app: $app"
                ;;
        esac
    done < selected.txt

    echo "Download process completed."
}

# Main function
main() {
    show_menu
    download_apps
}

main

