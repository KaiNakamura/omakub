#!/bin/bash

THEME_NAMES=("Tokyo Night" "Catppuccin" "Nord" "Everforest" "Gruvbox" "Kanagawa" "Ristretto" "Rose Pine" "Matte Black" "Osaka Jade")
THEME=$(gum choose "${THEME_NAMES[@]}" "<< Back" --header "Choose your theme" --height 12 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

if [ -n "$THEME" ] && [ "$THEME" != "<<-back" ]; then
  # Copy Kitty theme if it exists
  if [ -f "$OMAKUB_PATH/themes/$THEME/kitty.conf" ] && [ -f ~/.config/kitty/kitty.conf ]; then
    # Merge theme colors into kitty config or create a theme include
    mkdir -p ~/.config/kitty/themes
    cp $OMAKUB_PATH/themes/$THEME/kitty.conf ~/.config/kitty/themes/$THEME.conf
    # Add include line if not present
    if ! grep -q "include themes/$THEME.conf" ~/.config/kitty/kitty.conf; then
      echo "include themes/$THEME.conf" >> ~/.config/kitty/kitty.conf
    fi
  fi
  if [ -d "$HOME/.config/nvim" ]; then
    cp $OMAKUB_PATH/themes/$THEME/neovim.lua ~/.config/nvim/lua/plugins/theme.lua
  fi

  if [ -f "$OMAKUB_PATH/themes/$THEME/btop.theme" ]; then
    cp $OMAKUB_PATH/themes/$THEME/btop.theme ~/.config/btop/themes/$THEME.theme
    sed -i "s/color_theme = \".*\"/color_theme = \"$THEME\"/g" ~/.config/btop/btop.conf
  else
    sed -i "s/color_theme = \".*\"/color_theme = \"Default\"/g" ~/.config/btop/btop.conf
  fi

  source $OMAKUB_PATH/themes/$THEME/gnome.sh
  source $OMAKUB_PATH/themes/$THEME/tophat.sh
  source $OMAKUB_PATH/themes/$THEME/vscode.sh

  # Firefox theme support could be added here in the future if needed
fi

source $OMAKUB_PATH/bin/omakub-sub/menu.sh
