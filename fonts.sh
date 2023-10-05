#!/bin/bash

mkdir -p $HOME/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/RobotoMono.zip

unzip RobotoMono.zip -d $HOME/.local/share/fonts/RobotoMono/

rm RobotoMono.zip

fc-cache
