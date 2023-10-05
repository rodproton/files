#!/bin/bash

git clone https://github.com/neovim/neovim

cd neovim

#git checkout stable

make CMAKE_BUILD_TYPE=RelWithDebInfo

cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
