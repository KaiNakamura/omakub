#!/bin/bash

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Copy starship config if it doesn't exist
if [ ! -f ~/.config/starship.toml ]; then
  mkdir -p ~/.config
  cp ~/.local/share/omakub/configs/starship.toml ~/.config/starship.toml
fi

# Add starship init to zshrc if zsh is being used
# Note: If zsh is set up via app-zsh.sh, starship init is already included
if [ -f ~/.zshrc ] && ! grep -q "starship init zsh" ~/.zshrc; then
  echo '' >> ~/.zshrc
  echo '# Initialize starship prompt' >> ~/.zshrc
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

