#!/bin/bash

# Error handling
set -e

files() {
sudo cat > $HOME/.profile << "EOF"
# This file is not read by bash if ~/.bash_profile or ~/.bash_login exists

# If running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Startx
if [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ]; then
    exec startx &>/dev/null
fi

#Keyboard Remap
$HOME/.local/bin/remap-keys

# Golang 
export PATH=$PATH:/usr/local/go/bin
EOF

sudo cat > $HOME/.bashrc << "EOF"
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't add duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history length 
HISTSIZE=10000
HISTFILESIZE=20000

# Check window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

# "**" will match all files and zero or more directories and subdirectories.
shopt -s globstar

# Make less more friendly 
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Set colored prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# Display git branch
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[01;34m\]\w\[\033[32m\]\$(git_branch)\[\033[00m\] $ "
else
    PS1="\w \$(git_branch)$ "
fi
unset color_prompt force_color_prompt

# Enable color support of ls 
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features 
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#Enable vi-mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
EOF
}

fonts() {
    mkdir -p $HOME/.local/share/fonts

    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip 

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
    wget -O package.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.14/obsidian_1.4.14_amd64.deb

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
    sudo sed -i -e 's/bookworm/testing/g' /etc/apt/sources.list

    sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt autopurge -y

    sudo apt install -y xorg xclip build-essential git python3-pip i3 network-manager pcmanfm pulseaudio feh dunst unzip mpv curl flameshot keepassxc tmux wget ninja-build gettext cmake zathura parallel ffmpeg alacritty network-manager-gnome xcape fzf xcompmgr materia-gtk-theme xdo pandoc xterm
}

folders() {
    mkdir -p $HOME/.local

    mv $HOME/bin $HOME/.local/
}

cleanup() {
    sudo apt purge -y nano

    sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt autopurge -y
}

main() {
    folders
    packages
    files
    fonts
    firefox
    neovim
    obsidian
    brave
    cleanup
}

main

printf "\e[1;32mYou reboot\n"
