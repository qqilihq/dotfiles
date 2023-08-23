#!/bin/bash

/usr/sbin/softwareupdate --install-rosetta --agree-to-license

brew update
brew upgrade

brew install ansible
brew install cliclick
brew install dnsmasq
brew install hashicorp/tap/hashicorp-vagrant
brew install jq
brew install mas
brew install maven
brew install tldr
brew install volta

brew tap adoptopenjdk/openjdk
brew install adoptopenjdk/openjdk/adoptopenjdk14

brew install --cask affinity-designer 
brew install --cask affinity-photo 
brew install --cask affinity-publisher
brew install --cask docker
brew install --cask easyfind
brew install --cask eclipse-rcp
brew install --cask firefox
brew install --cask fork
brew install --cask google-chrome
brew install --cask grandperspective
brew install --cask keka
brew install --cask knime
brew install --cask mactracker
brew install --cask phoenix
brew install --cask rapidapi
brew install --cask sequel-ace
brew install --cask steam
brew install --cask studio-3t
brew install --cask transmit
brew install --cask virtualbox
brew install --cask visual-studio-code

# Install old 1Password 7
brew tap homebrew/cask-versions
brew install --cask 1password7
# Chrome extension: https://chrome.google.com/webstore/detail/1password-extension-deskt/aomjjhallfgjeglblehebfpbcfeobpgk

# Fonts
brew tap homebrew/cask-fonts
brew install font-arimo

mas install 1529448980 # Reeder 5
mas install 1437501942 # RSS Button for Safari
