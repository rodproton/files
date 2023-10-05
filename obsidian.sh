#!/bin/bash

wget -O package.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.14/obsidian_1.4.14_amd64.deb

sudo apt install -y ./package.deb

rm package.deb
