#!/bin/bash

# Kitty is a fast, feature-rich, GPU-based terminal emulator. See https://sw.kovidgoyal.net/kitty/
sudo apt install -y kitty
mkdir -p ~/.config/kitty

# Copy kitty config from dotfiles if it doesn't exist
if [ ! -f ~/.config/kitty/kitty.conf ]; then
  if [ -f ~/repos/dotfiles/kitty/kitty.conf ]; then
    cp ~/repos/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
  fi
fi

# Set kitty as default terminal
source ~/.local/share/omakub/install/desktop/set-kitty-default.sh

