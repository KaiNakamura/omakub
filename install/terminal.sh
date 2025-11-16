#!/bin/bash

# Needed for all installers
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl git unzip

# Clone dotfiles repo to ~/repos/dotfiles if it doesn't exist
DOTFILES_DIR="$HOME/repos/dotfiles"
mkdir -p "$HOME/repos"
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles repository..."
  git clone https://github.com/KaiNakamura/dotfiles.git "$DOTFILES_DIR" || true
else
  echo "Dotfiles repository already exists, updating..."
  cd "$DOTFILES_DIR"
  git pull origin master || true
  cd - > /dev/null
fi

# Run terminal installers
for installer in ~/.local/share/omakub/install/terminal/*.sh; do source $installer; done
