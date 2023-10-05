#!/usr/bin/bash

# Error handling
set -e

# Update
sudo sed -i -e 's/bookworm/testing/g' /etc/apt/sources.list

sudo apt -y update && sudo apt -y upgrade && sudo apt -y full-upgrade && sudo apt -y dist-upgrade && sudo apt -y autoremove && sudo apt -y autoclean && sudo apt -y autopurge

# Programs and Packages
sudo apt install -y xorg build-essential git python3-pip i3 network-manager pcmanfm pulseaudio feh dunst unzip mpv curl flameshot keepassxc tmux wget ninja-build gettext cmake zathura parallel ffmpeg

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
sudo apt -y purge nano
sudo apt -y update && sudo apt -y upgrade && sudo apt -y full-upgrade && sudo apt -y dist-upgrade && sudo apt -y autoremove && sudo apt -y autoclean && sudo apt -y autopurge

printf "\e[1;32mYou reboot\n"
