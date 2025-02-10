#!/bin/bash

# Install zsh and git (handling both apt and pkg)
if command -v apt &> /dev/null; then
  sudo apt install zsh git -y
elif command -v pkg &> /dev/null; then
  pkg install zsh git
else
  echo "No package manager (apt or pkg) found. Please install zsh and git manually."
  exit 1
fi

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Check if ZSH_CUSTOM is defined, otherwise use the default
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"


# Add plugins to ~/.zshrc  (More robust method)
plugins_to_add=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)

# Check if .zshrc exists, if not create it
if [ ! -f ~/.zshrc ]; then
  touch ~/.zshrc
fi

# Use sed to add the plugins line, avoiding duplicates and handling existing plugins
sed -i -E "s/plugins=\((.*)\)/plugins=(\1 ${plugins_to_add[@]})/g" ~/.zshrc

# If the plugins line doesn't exist, add it. This is a fallback in case the regex doesn't match.
if ! grep -q "plugins=" ~/.zshrc; then
  echo "plugins=(${plugins_to_add[@]})" >> ~/.zshrc
fi


# Source the .zshrc file to apply changes immediately (optional but recommended)
source ~/.zshrc

echo "Oh My Zsh and plugins installed successfully!"