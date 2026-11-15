#!/bin/sh
set -e

# Reinstall icon themes:
sudo apt -y update
sudo apt -y install --reinstall adwaita-icon-theme yaru-theme-icon

# Update icon cache:
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor/
sudo gtk-update-icon-cache -f -t /usr/share/icons/Yaru/

# Ensure icon theme:
gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
