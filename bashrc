if [ -f ~/.ohmyshell/aliases ]; then
    . ~/.ohmyshell/aliases
fi

# Add the ~/scripts folder itself first
PATH="/c/Program Files/Sublime Text:$HOME/.ohmyshell/scripts:$PATH"

# Loop through subdirectories of ~/scripts and add them to PATH
for dir in "$HOME/.ohmyshell/scripts"/*/; do
    PATH="$dir:$PATH"
done

export PATH