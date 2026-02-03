#!/usr/bin/env bash
#
# Utility functions for scripts

# Get the dotfiles directory by resolving symlinks from the calling script
# Usage: dotfiles_dir=$(get_dotfiles_dir "${BASH_SOURCE[0]}")
get_dotfiles_dir() {
    local script_path="$1"
    while [ -L "$script_path" ]; do
        local script_dir="$(cd -P "$(dirname "$script_path")" && pwd)"
        script_path="$(readlink "$script_path")"
        [[ $script_path != /* ]] && script_path="$script_dir/$script_path"
    done
    echo "$(cd -P "$(dirname "$script_path")/.." && pwd)"
}

cmd_exists() {
  if [ ! $# -eq 1 ]; then
    echo "usage: cmd_exists <command>"
    return 1
  fi

  command -v $1 > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "command '$1' not found"
    return 1
  fi
}
