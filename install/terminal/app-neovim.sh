#!/bin/bash

cd /tmp
wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
tar -xf nvim.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm -f nvim-linux-x86_64.tar.gz
cd -

# Install dependencies
sudo apt install -y luarocks tree-sitter-cli ripgrep

# Setup kai.nvim config
REPO_DIR="$HOME/repos/kai.nvim"
CONFIG_DIR="$HOME/.config/nvim"

# Ensure repos directory exists
mkdir -p "$HOME/repos"

# Clone or update kai.nvim repo
if [ ! -d "$REPO_DIR" ]; then
  echo "Cloning kai.nvim..."
  git clone https://github.com/KaiNakamura/kai.nvim.git "$REPO_DIR"
else
  echo "Updating kai.nvim..."
  cd "$REPO_DIR"
  git checkout master
  git pull origin master || true
  cd - > /dev/null
fi

# Create symlink for nvim config
echo "Creating symlink for nvim config..."
rm -rf "$CONFIG_DIR"
ln -sf "$REPO_DIR" "$CONFIG_DIR"
