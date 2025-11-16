#!/bin/bash

# Kitty is a fast, feature-rich, GPU-based terminal emulator. See https://sw.kovidgoyal.net/kitty/
sudo apt install -y kitty
mkdir -p ~/.config/kitty

# Copy basic kitty config if it doesn't exist
if [ ! -f ~/.config/kitty/kitty.conf ]; then
  # Create a basic kitty config
  cat > ~/.config/kitty/kitty.conf << 'EOF'
# Basic Kitty configuration
font_family      monospace
font_size        12.0
background_opacity 0.95

# Window settings
window_padding_width 8
confirm_os_window_close 0
EOF
fi

# Set kitty as default terminal
source ~/.local/share/omakub/install/desktop/set-kitty-default.sh

