#!/bin/bash

# Define the line to add
BASHRC="[[ -f $HOME/.ohmyshell/bashrc ]] && source $HOME/.ohmyshell/bashrc"
ZSHRC="[[ -f $HOME/.ohmyshell/zshrc ]] && source $HOME/.ohmyshell/zshrc"

# Check if the line already exists in $HOME/.bashrc
if ! grep -Fxq "$BASHRC" $HOME/.bashrc; then
    echo "$BASHRC" >> $HOME/.bashrc
    echo "[[ -f $HOME/.ohmyshell/bashrc ]] && source $HOME/.ohmyshell/bashrc added to $HOME/.bashrc"
else
    echo "[[ -f $HOME/.ohmyshell/bashrc ]] && source $HOME/.ohmyshell/bashrc already exists in $HOME/.bashrc"
fi

# Check if the line already exists in $HOME/.zshrc
if ! grep -Fxq "$ZSHRC" $HOME/.zshrc; then
    echo "$ZSHRC" >> $HOME/.zshrc
    echo "[[ -f $HOME/.ohmyshell/zshrc ]] && source $HOME/.ohmyshell/zshrc added to $HOME/.zshrc"
else
    echo "[[ -f $HOME/.ohmyshell/zshrc ]] && source $HOME/.ohmyshell/zshrc already exists in $HOME/.zshrc"
fi
