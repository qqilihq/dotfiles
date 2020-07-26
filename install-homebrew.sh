#!/bin/bash

brew update
brew upgrade

brew install cliclick
brew install ctop
brew install dive
brew install gifify
brew install gnupg
brew install gradle
brew install maven
brew install nmap
brew install node@12
brew install siege
brew install titlecase
brew install tldr
brew install wget
# brew install yarn --without-node

brew cask install 1password
brew cask install docker
brew cask install easyfind
brew cask install firefox
brew cask install fork
brew cask install google-chrome
brew cask install grandperspective
brew cask install keka
brew cask install mactracker
brew cask install nextcloud
brew cask install paw
brew cask install phoenix
brew cask install robo-3t
brew cask install sublime-text
brew cask install transmit
brew cask install visual-studio-code

# do not install this via homebrew:
# https://github.com/yarnpkg/website/issues/913
curl -o- -L https://yarnpkg.com/install.sh | bash

brew cleanup
