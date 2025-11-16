#!/bin/bash

# Install zsh if not already installed
sudo apt install -y zsh

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Configure zsh with oh-my-zsh and plugins
if [ ! -f ~/.zshrc ] || ! grep -q "oh-my-zsh" ~/.zshrc; then
  # Create basic .zshrc with oh-my-zsh
  cat > ~/.zshrc << 'EOF'
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME=""

# Plugins to load
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Initialize starship prompt if installed
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Initialize zoxide if installed
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Initialize fzf if installed
if command -v fzf &> /dev/null; then
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
  [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
fi

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=32768
SAVEHIST=32768
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# Search command history with Ctrl+R
bindkey '^R' history-incremental-search-backward

# Delete word backwards with Ctrl+Backspace
bindkey '^H' backward-kill-word

# Editor
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# PATH
export PATH="./bin:$HOME/.local/bin:$HOME/.local/share/omakub/bin:$PATH"

# Omakub path
export OMAKUB_PATH="$HOME/.local/share/omakub"
EOF
fi

# Install zsh-syntax-highlighting plugin
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Install zsh-autosuggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# Update .zshrc to include the plugins
if [ -f ~/.zshrc ]; then
  # Update plugins line if it exists
  if grep -q "^plugins=" ~/.zshrc; then
    sed -i 's/^plugins=(.*)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc
  fi
fi

# Source aliases and functions from omakub defaults if they exist
if [ -f ~/.zshrc ] && [ -d "$HOME/.local/share/omakub/defaults/bash" ]; then
  # Add omakub aliases and functions if not already present
  if ! grep -q "omakub/defaults/bash/aliases" ~/.zshrc; then
    echo '' >> ~/.zshrc
    echo '# Omakub aliases and functions' >> ~/.zshrc
    echo '[ -f ~/.local/share/omakub/defaults/bash/aliases ] && source ~/.local/share/omakub/defaults/bash/aliases' >> ~/.zshrc
    echo '[ -f ~/.local/share/omakub/defaults/bash/functions ] && source ~/.local/share/omakub/defaults/bash/functions' >> ~/.zshrc
  fi
fi

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  sudo chsh -s $(which zsh) $USER
fi

