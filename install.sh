#!/usr/bin/bash

# Error handling
set -e

# Folders
mv $HOME/bin/ $HOME/.local/

# Update
sudo sed -i -e 's/bookworm/testing/g' /etc/apt/sources.list

sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt autopurge -y

# Programs and Packages
sudo apt install -y xorg xclip build-essential git python3-pip i3 network-manager pcmanfm pulseaudio feh dunst unzip mpv curl flameshot keepassxc tmux wget ninja-build gettext cmake zathura parallel ffmpeg compton alacritty

# Files
bash $HOME/files.sh

# Fonts
bash $HOME/fonts.sh

# Firefox
sudo bash $HOME/firefox.sh

# Neovim
bash $HOME/neovim.sh

# Obsidian
bash $HOME/obsidian.sh

# Brave
bash $HOME/brave.sh

# Cleanup
sudo apt purge -y nano

sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt autopurge -y

printf "\e[1;32mYou reboot\n"
