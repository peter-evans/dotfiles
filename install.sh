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

# Configure GitHub MCP server for VS Code in Codespaces
if [ "${CODESPACES:-}" = "true" ]; then
    mcp_config_dir="$HOME/.vscode-remote/data/User"
    mcp_config_file="$mcp_config_dir/mcp.json"
    mkdir -p "$mcp_config_dir"
    echo -n "Configuring mcp.json ..."
    if [ -f "$mcp_config_file" ]; then
        # Merge with existing configuration
        jq -s '.[0] * .[1]' "$mcp_config_file" "$dotfiles_dir/mcp.json" > "$mcp_config_file.tmp"
        mv "$mcp_config_file.tmp" "$mcp_config_file"
    else
        cp "$dotfiles_dir/mcp.json" "$mcp_config_file"
    fi
    echo "done"
fi
