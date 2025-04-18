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
  if [ -e "$2" ]; then
    echo "$2 already exists -- review for changes, merge with repository, and delete."
    # TODO introduce a --force flag?
    exit 1
  fi
  if [ ! -e "$1" ]; then
    echo "$1 not found."
    exit 1
  fi
  ln -s "$1" "$2"
  echo "$1 -> $2"
}

symlink_if_not_exists "${PWD}/.bash_profile" "${HOME}/.bash_profile"
symlink_if_not_exists "${PWD}/.phoenix.js" "${HOME}/.phoenix.js"
symlink_if_not_exists "${PWD}/.inputrc" "${HOME}/.inputrc"
symlink_if_not_exists "${PWD}/.zshrc" "${HOME}/.zshrc"
symlink_if_not_exists "${PWD}/toolchains.xml" "${HOME}/.m2/toolchains.xml"
symlink_if_not_exists "${PWD}/.huskyrc" "${HOME}/.huskyrc"
symlink_if_not_exists "${PWD}/.gitignore_global" "${HOME}/.gitignore_global"
symlink_if_not_exists "${PWD}/.config/husky" "${HOME}/.config/husky"

# put ssh config in iCloud Drive -> `./sync/.ssh_config`
mkdir -p "${HOME}/.ssh"
symlink_if_not_exists "${HOME}/Library/Mobile Documents/com~apple~CloudDocs/.sync/ssh_config" "${HOME}/.ssh/config"
