#!/bin/sh

# wsl2はwindows側で実行するため、設定が不要になる

CONFIG_DIR="$HOME/.config"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

if [ ! -d "$CONFIG_DIR" ]; then
  echo "Creating config directory at $CONFIG_DIR"
  mkdir -p "$CONFIG_DIR"
fi

if [ ! -L "$CONFIG_DIR/starship.toml" ]; then
  echo "Creating symbolic link for starship.toml"
  ln -s "$SCRIPT_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
fi