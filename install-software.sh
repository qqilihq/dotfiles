#!/bin/bash

brew update
brew upgrade

brew install dnsmasq
brew install maven
brew install tldr
brew install volta

brew tap adoptopenjdk/openjdk
brew install adoptopenjdk/openjdk/adoptopenjdk14

brew install --cask docker
brew install --cask easyfind
brew install --cask eclipse-rcp
brew install --cask fork
brew install --cask google-chrome
brew install --cask grandperspective
brew install --cask keka
brew install --cask mactracker
brew install --cask phoenix
brew install --cask rapidapi
brew install --cask steam
brew install --cask studio-3t
brew install --cask transmit
brew install --cask visual-studio-code

brew tap homebrew/cask-versions
brew install --cask 1password7
