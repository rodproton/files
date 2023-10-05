#!/bin/bash

sudo cat >> $HOME/.profile << "EOF"

# Startx
if [ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ]; then
	exec startx &>/dev/null
fi

# Golang 
export PATH=$PATH:/usr/local/go/bin

#Keyboard Remap
$HOME/.local/bin/remap-keys

# xterm
xrdb -merge .Xresources
EOF


sudo cat >> $HOME/.bashrc << "EOF"

#Enable vi mode
set -o vi
bind -m vi-command ' Control-l: clear-screen'
bind -m vi-insert ' Control-l: clear-screen'
EOF
