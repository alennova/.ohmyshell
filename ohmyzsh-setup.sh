#!/usr/bin/bash

# Check if zsh and git are installed
if ! command -v zsh &> /dev/null || ! command -v git &> /dev/null; then
    echo "Installing zsh and git..."
    sudo apt update && sudo apt install -y zsh git
else
    echo "zsh and git are already installed."
fi

# Check if Oh My Zsh is already installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed."
else
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Define plugins and their repositories
declare -A plugins
plugins=(
    [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
    [fast-syntax-highlighting]="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
)

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
mkdir -p "$ZSH_CUSTOM/plugins"

installed_plugins=(git)

# Prompt user for each plugin installation
for plugin in "${!plugins[@]}"; do
    read -p "Do you want to install $plugin? [Y/n] " response
    response=${response,,}  # Convert to lowercase
    if [[ -z "$response" || "$response" == "y" ]]; then
        if [ -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
            echo "$plugin is already installed."
        else
            echo "Installing $plugin..."
            git clone "${plugins[$plugin]}" "$ZSH_CUSTOM/plugins/$plugin"
            installed_plugins+=("$plugin")
        fi
    else
        echo "Skipping $plugin."
    fi
done

# Update .zshrc file
if grep -q "^plugins=(" "$HOME/.zshrc"; then
    sed -i "s/^plugins=(.*)/plugins=(${installed_plugins[*]})/" "$HOME/.zshrc"
else
    echo "plugins=(${installed_plugins[*]})" >> "$HOME/.zshrc"
fi

# Add additional configuration to .zshrc
ZSHRC="[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc"
if ! grep -Fxq "$ZSHRC" "$HOME/.zshrc"; then
    echo "$ZSHRC" >> "$HOME/.zshrc"
    echo "[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc added to ~/.zshrc"
else
    echo "[[ -f ~/.ohmyshell/zshrc ]] && source ~/.ohmyshell/zshrc already exists in ~/.zshrc"
fi

echo "Installation complete. Restart the terminal or run 'exec zsh' to apply changes."
