#!/bin/bash

# Clone the plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)" >> $HOME/.ohmyshell/zshrc

echo "Zsh plugins installed and $HOME/.ohmyshell/zshrc updated.  New shell sessions will have the plugins active."