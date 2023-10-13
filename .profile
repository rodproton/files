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
