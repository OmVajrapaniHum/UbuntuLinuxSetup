#!/bin/sh
set -e

architecture="$(dpkg --print-architecture)"
if [ "$architecture" != "amd64" ]; then
    echo "Google Chrome only provides official Linux .deb packages for amd64 (detected: $architecture)." >&2
    exit 1
fi

sudo apt -y update
sudo apt install -y wget ca-certificates

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

dl_host="dl.google.com"
deb_file="$tmp_dir/google-chrome-stable_current_$architecture.deb"
wget -O "$deb_file" "https://${dl_host}/linux/direct/google-chrome-stable_current_${architecture}.deb"

sudo apt -y install "$deb_file"

ls -l /etc/apt/sources.list.d/google-chrome*
cat /etc/apt/sources.list.d/google-chrome*
sudo apt -y update
