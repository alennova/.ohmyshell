#!/bin/bash

# Clone the plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

# Check if the line already exists in ~/.zshrc
ZSHRC="[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc"
if ! grep -Fxq "$ZSHRC" ~/.zshrc; then
    echo "$ZSHRC" >> ~/.zshrc
    echo "[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc added to ~/.zshrc"
else
    echo "[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc already exists in ~/.zshrc"
fi

PLUGINS="plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting)"
# Check if the line already exists in ~/.zshrc
if ! grep -Fxq "$PLUGINS" $HOME/.ohmyshell/zshrc; then
    echo "$PLUGINS" >> $HOME/.ohmyshell/zshrc
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting) added to $HOME/.ohmyshell/zshrc"
else
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting) already exists in $HOME/.ohmyshell/zshrc"
fi