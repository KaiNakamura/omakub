#!/bin/bash

# Only ask for default desktop app choices when running Gnome
# No optional apps to prompt for
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  export OMAKUB_FIRST_RUN_OPTIONAL_APPS=''
fi

