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
    whiptail --title "App Selection" --checklist --separate-output "Select the apps you want to download:" 20 60 14 \
    "Thunar (GUI File Manager)" "" on \
    "Nicotine+ (Music-sharing Client)" "" off \
    "Signal Desktop" "" on \
    "Secrets (GUI Password Manager)" "" off \
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
            "Thunar (GUI File Manager)")
                echo "Downloading Thunar..."
                sudo pacman -S --noconfirm thunar gvfs-mtp tumbler unzip file-roller android-tools xdg-user-dirs
                ;;
            "Nicotine+ (Music-sharing Client)")
                echo "Downloading Nicotine+..."
                sudo pacman -S --noconfirm nicotine+
                ;;
            "Signal Desktop")
                echo "Downloading Signal Desktop..."
                sudo pacman -S --noconfirm signal-desktop
                ;;
            "Secrets (GUI Password Manager)")
                echo "Downloading Secrets..."
                sudo pacman -S --noconfirm secrets
                ;;
            "qbittorrent")
                echo "Downloading qBittorrent..."
                sudo pacman -S --noconfirm qbittorrent
                ;;
            "Spotify")
                echo "Downloading Spotify..."
                paru -S --noconfirm spotify zenity
                ;;
            "Rust desk")
                echo "Downloading Rust desk..."
                paru -S --noconfirm rustdesk-bin
                ;;
            "Chromium")
                echo "Downloading Chromium..."
                sudo pacman -S --noconfirm chromium
                ;;
            "Thromium")
                echo "Downloading Thromium..."
                paru -S --noconfirm thorium-browser-bin
                ;;
            "Floorp (What Firefox should be)")
                echo "Downloading Floorp..."
                paru -S --noconfirm floorp-bin
                ;;
            "Firefox")
                echo "Downloading Firefox..."
                sudo pacman -S --noconfirm firefox
                ;;
            "Librewolf")
                echo "Downloading Librewolf..."
                paru -S --noconfirm librewolf-bin
                ;;
            "VS-Code (Microsoft)")
                echo "Downloading VS-Code (Microsoft)..."
                paru -S --noconfirm visual-studio-code
                ;;
            "VS-Codium")
                echo "Downloading VS-Codium..."
                paru -S --noconfirm vscodium-bin
                ;;
            "LibreOffice")
                echo "Downloading LibreOffice..."
                sudo pacman -S --noconfirm libreoffice-fresh
                ;;
            "Thunderbird")
                echo "Downloading Thunderbird..."
                sudo pacman -S --noconfirm thunderbird
                ;;
            "OBS Studio")
                echo "Downloading OBS Studio..."
                sudo pacman -S --noconfirm obs-studio
                ;;
            "Okular (Document Viewer)")
                echo "Downloading Okular..."
                sudo pacman -S --noconfirm okular
                ;;
            "Vencord (Discord client)")
                echo "Downloading Vencord (Discord client)..."
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

