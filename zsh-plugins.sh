#!/bin/bash

# Clone the plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting


# Add plugins to ~/.zshrc.  We'll use a robust method to avoid duplicates.
ZSHRC="$HOME/.zshrc"

# Check if the plugins line already exists. If so, we'll modify it. If not, we'll add it.
if grep -q 'plugins=\(' "$ZSHRC"; then
  # Modify existing plugins line, adding new plugins if they're not already there.
  sed -i -E 's/(plugins=\()(.*)\)/ \1\2 git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting/g' "$ZSHRC"

  #Remove duplicates
  sed -i -E 's/\b(\w+)\b(?=.*\b\1\b)//g' "$ZSHRC" #Remove duplicate words

else
  # Add the plugins line.  We'll find the line with "plugins=(" and add to it, or append if not found.
  if grep -q 'plugins=\(' "$ZSHRC"; then
    sed -i '/plugins=\(/a \
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)' "$ZSHRC"
  else
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)" >> "$ZSHRC"
  fi
fi


# Source the .zshrc file to apply changes immediately
source "$ZSHRC"

echo "Zsh plugins installed and .zshrc updated.  New shell sessions will have the plugins active."