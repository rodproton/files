#!/bin/bash

mkdir -p $HOME/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip 

unzip FiraMono.zip -d $HOME/.local/share/fonts/FiraMono/

rm FiraMono.zip

fc-cache
