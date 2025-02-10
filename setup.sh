#!/bin/bash

# Define the line to add
BASHRC="[[ -f ~/.ohmyshell/bashrc ]] && source ~/.ohmyshell/bashrc"
ZSHRC="[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc"

# Check if the line already exists in ~/.bashrc
if ! grep -Fxq "$BASHRC" ~/.bashrc; then
    echo "$BASHRC" >> ~/.bashrc
    echo "[[ -f ~/.ohmyshell/bashrc ]] && source ~/.ohmyshell/bashrc added to ~/.bashrc"
else
    echo "[[ -f ~/.ohmyshell/bashrc ]] && source ~/.ohmyshell/bashrc already exists in ~/.bashrc"
fi

# Check if the line already exists in ~/.zshrc
if ! grep -Fxq "$ZSHRC" ~/.zshrc; then
    echo "$ZSHRC" >> ~/.zshrc
    echo "[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc added to ~/.zshrc"
else
    echo "[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc already exists in ~/.zshrc"
fi
