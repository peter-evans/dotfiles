#!/bin/bash
# Creates symlinks from the home directory to dotfiles in this repository

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
    if [ -L ~/.$file ]; then
        echo "$file is a symlink; skipping backup"
    else
        echo -n "Moving $file from ~ to $backup_dir if it exists ..."
        mv ~/.$file $backup_dir/
        echo "done"
    fi
    echo -n "Creating symlink to $file in home directory ..."
    ln -sf $dotfiles_dir/$file ~/.$file
    echo "done"
done
