#!/bin/sh
set -e

echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections

sudo rm -f /etc/apt/sources.list.d/vscode.sources /etc/apt/sources.list.d/vscode.list

sudo apt -y update
sudo apt install -y wget gpg ca-certificates

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

ms_host="packages.microsoft.com"
microsoft_asc="$tmp_dir/microsoft.asc"
microsoft_gpg='/usr/share/keyrings/microsoft.gpg'

wget -O "$microsoft_asc" "https://${ms_host}/keys/microsoft.asc"
test -s "$microsoft_asc"
sudo gpg --yes --dearmor -o "$microsoft_gpg" "$microsoft_asc"
sudo chmod 644 "$microsoft_gpg"

vscode_sources_path='/etc/apt/sources.list.d/vscode.sources'
vscode_sources_temp="$tmp_dir/vscode.sources"

cat <<SOURCES >"$vscode_sources_temp"
Types: deb
URIs: https://${ms_host}/repos/code
Suites: stable
Components: main
Architectures: amd64
Signed-By: $microsoft_gpg
SOURCES

sudo cp -fv "$vscode_sources_temp" "$vscode_sources_path"
sudo chmod 644 "$vscode_sources_path"

sudo apt -y update
sudo apt install -y code git
