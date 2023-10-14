#!/bin/bash

# Error handling
set -e

fonts() {
    mkdir -p $HOME/.local/share/fonts

    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.zip

    unzip FiraMono.zip -d $HOME/.local/share/fonts/FiraMono/

    rm FiraMono.zip

    fc-cache
}

firefox() {
    wget -O package.tar https://download.mozilla.org/\?product\=firefox-latest-ssl\&os\=linux64\&lang\=en-US

    sudo tar -xvf package.tar -C /opt/ 

    rm package.tar

sudo cat > /usr/share/applications/firefox.desktop << "EOF"
[Desktop Entry]
Name=Firefox
Comment=Web Browser
Exec=/opt/firefox/firefox %u
Terminal=false
Type=Application
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Actions=Private;

[Desktop Action Private]
Exec=/opt/firefox/firefox --private-window %u
Name=Open in private mode
EOF

    sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
}

neovim() {
    git clone https://github.com/neovim/neovim

    cd neovim

    #git checkout stable

    make CMAKE_BUILD_TYPE=RelWithDebInfo

    cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

    rm -rf $HOME/neovim/
}

obsidian() {
    url=$(curl -Is "https://github.com/obsidianmd/obsidian-releases/releases/latest" | grep -i "location:" | awk -F' ' '{print $2}' | tr -d '\r')
    version=${url##*/v}
    latest="https://github.com/obsidianmd/obsidian-releases/releases/latest/download/obsidian_${version}_amd64.deb"

    wget -O package.deb $latest 

    sudo apt install -y ./package.deb

    rm package.deb
}

brave() {
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update -y

    sudo apt install -y brave-browser 
}

packages() {
    #sudo sed -i -e 's/bookworm/testing/g' /etc/apt/sources.list

    sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt autopurge -y

    sudo apt install -y xorg xclip build-essential git python3-pip i3 network-manager pcmanfm pulseaudio feh dunst unzip mpv curl flameshot keepassxc tmux wget ninja-build gettext cmake zathura parallel ffmpeg alacritty network-manager-gnome xcape fzf xcompmgr materia-gtk-theme xdo pandoc xterm
}

folders() {
    mkdir -p $HOME/.local

    mv bin/ $HOME/.local/
}

cleanup() {
    sudo apt purge -y nano

    sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt autopurge -y
}

main() {
    packages
    fonts
    firefox
    neovim
    obsidian
    brave
    cleanup
}

main

printf "\e[1;32mYou reboot\n"
