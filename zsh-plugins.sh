#!/bin/bash

# Clone the plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

sed -i 's/^plugins=(git)$/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)/' $HOME/.zshrc

# Check if the line already exists in $HOME/.zshrc
ZSHRC="[[ -f $HOME/.ohmyshell/zshrc ]] && source $HOME/.ohmyshell/zshrc"
if ! grep -Fxq "$ZSHRC" $HOME/.zshrc; then
    echo "$ZSHRC" >> $HOME/.zshrc
    echo "[[ -f $HOME/.ohmyshell/zshrc ]] && source $HOME/.ohmyshell/zshrc added to $HOME/.zshrc"
else
    echo "[[ -f $HOME/.ohmyshell/zshrc ]] && source $HOME/.ohmyshell/zshrc already exists in $HOME/.zshrc"
fi
