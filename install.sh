#!/bin/bash

set -e

# symlinks the relevant dotfiles with the repository

# Change to script directory
cd "$(dirname "$0")"

# $1 source file
# $2 destination file
symlink_if_not_exists() {
  if [ -L "$2" ]; then
    echo "$2 is already a symlink -- nothing to do"
    return
  fi
  if [ -f "$2" ]; then
    echo "$2 already exists -- review for changes, merge with repository, and delete."
    # TODO introduce a --force flag?
    exit 1
  fi
  if [ ! -f "$1" ]; then
    echo "$1 not found."
    exit 1
  fi
  ln -s "$PWD/$1" "$2"
  echo "$PWD/$1 -> $2"
}

symlink_if_not_exists ".bash_profile" "${HOME}/.bash_profile"
symlink_if_not_exists ".phoenix.js" "${HOME}/.phoenix.js"
symlink_if_not_exists ".inputrc" "${HOME}/.inputrc"
