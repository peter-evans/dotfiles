#!/usr/bin/env bash
#
# Creates symlinks from the home directory to dotfiles in this repository

set -euo pipefail

source script/utils.sh

dotfiles_dir=$PWD
backup_dir=~/dotfiles_backup
files="gitconfig" # space-separated list of files/folders to symlink in homedir

# Backup existing dotfiles
echo -n "Creating $backup_dir for backup of any existing dotfiles in ~ ..."
mkdir -p $backup_dir
echo "done"

# Change to the dotfiles directory
echo -n "Changing to the $dotfiles_dir directory ..."
cd $dotfiles_dir
echo "done"

# Backup any existing dotfiles and then create symlinks
for file in $files; do
    if [ ! -e ~/.$file ]; then
        echo "$file doesn't exist; skipping backup"
    elif [ -L ~/.$file ]; then
        echo "$file is a symlink; skipping backup"
    else
        echo -n "Moving $file from ~ to $backup_dir ..."
        mv ~/.$file $backup_dir/
        echo "done"
    fi
    echo -n "Creating symlink to $file in home directory ..."
    ln -sf $dotfiles_dir/$file ~/.$file
    echo "done"
done

# Install ripgrep on codespaces
if [ "${CODESPACES:-}" = "true" ] && cmd_exists apt-get && ! cmd_exists rg; then
    sudo apt-get update && sudo apt-get install -y ripgrep
fi

# Add bin directory to PATH for custom commands
if [ -d "$dotfiles_dir/bin" ]; then
    echo -n "Creating symlinks for bin commands ..."
    mkdir -p "$HOME/.local/bin"
    for cmd in "$dotfiles_dir/bin"/*; do
        ln -sf "$cmd" "$HOME/.local/bin/$(basename "$cmd")"
    done
    echo "done"
fi
