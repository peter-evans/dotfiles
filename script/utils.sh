#!/usr/bin/env bash
#
# Utility functions for scripts

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
