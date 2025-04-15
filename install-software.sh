#!/bin/bash

/usr/sbin/softwareupdate --install-rosetta --agree-to-license

brew update
brew upgrade

brew install ansible
brew install cliclick
brew install deno
brew install dive
brew install dnsmasq
brew install dust
brew install gifify
brew install gnupg
brew install hashicorp/tap/hashicorp-vagrant
brew install hudochenkov/sshpass/sshpass
brew install itsycal
brew install jq
brew install maccy
brew install mas
brew install maven
brew install mitmproxy
brew install nmap
brew install pearcleaner
brew install pika
brew install ripgrep
brew install shellcheck
brew install telnet
brew install tldr
brew install volta
brew install zoxide

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
brew install --cask imageoptim
brew install --cask keka
brew install --cask knime
brew install --cask lulu
brew install --cask mactracker
brew install --cask phoenix
brew install --cask rapidapi
brew install --cask sequel-ace
brew install --cask steam
brew install --cask studio-3t
brew install --cask transmit
brew install --cask tunnelblick
brew install --cask virtualbox
brew install --cask visual-studio-code
brew install --cask wiso-steuer-2024
brew install --cask zed

# Install old 1Password 7
brew tap homebrew/cask-versions
brew install --cask 1password@7
# Chrome extension: https://chrome.google.com/webstore/detail/1password-extension-deskt/aomjjhallfgjeglblehebfpbcfeobpgk

brew install --cask temurin@17
brew install --cask temurin@21

# Fonts
brew tap homebrew/cask-fonts
brew install font-arimo
brew install font-fira-sans
brew install font-inter
brew install font-open-sans
brew install font-pt-sans

mas install 1529448980 # Reeder 5
mas install 1437501942 # RSS Button for Safari
mas install 409201541 # Pages
mas install 409203825 # Numbers
mas install 409183694 # Keynote

# oasdiff
brew tap tufin/homebrew-tufin
brew install oasdiff
