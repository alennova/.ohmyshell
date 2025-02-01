#!/bin/bash

# Define the line to add
BASHRC="[[ -f ~/.ohmyshell/bashrc ]] && source ~/.ohmyshell/bashrc"
ZSHRC="[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc"

# Check if the line already exists in ~/.bashrc
if ! grep -Fxq "$BASHRC" ~/.bashrc; then
    echo "$BASHRC" >> ~/.bashrc
    echo "Line added to ~/.bashrc"
else
    echo "Line already exists in ~/.bashrc"
fi

# Check if the line already exists in ~/.zshrc
if ! grep -Fxq "$ZSHRC" ~/.zshrc; then
    echo "$ZSHRC" >> ~/.zshrc
    echo "Line added to ~/.zshrc"
else
    echo "Line already exists in ~/.zshrc"
fi
