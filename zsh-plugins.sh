#!/bin/bash

# Clone the plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &&
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions &&
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting &&

echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)" >> $HOME/.ohmyshell/zshrc

echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting) added in $HOME/.ohmyshell/zshrc file"

$/.oh-my-zsh/custom/plugins/