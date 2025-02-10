if [ -f $HOME/.ohmyshell/aliases ]; then
    . $HOME/.ohmyshell/aliases
fi

# Add the $HOME/scripts folder itself first
PATH="$HOME/.ohmyshell/scripts:$PATH"

# Loop through subdirectories of $HOME/scripts and add them to PATH
for dir in "$HOME/.ohmyshell/scripts"/*/; do
    PATH="$dir:$PATH"
done

export PATH

