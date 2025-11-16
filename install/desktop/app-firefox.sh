#!/bin/bash

# Firefox is already installed on Ubuntu by default, but ensure it's set as default browser
sudo apt install -y firefox
xdg-settings set default-web-browser firefox.desktop

