# #######
# aliases
# #######

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ~='cd ~'
alias -- -="cd -"
alias dt='cd ~/Desktop'
# alias dc='docker-compose'
# alias dps='docker ps -a'

# -l long format
# -a include . directories
# -F additional characters for type (e.g. `/` after dir)
# -h human-readable units
alias ll='ls -laFh'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Create an invoice number (ten random digits, zero-padded)
alias invoicenumber='printf "%010d" $(jot -r 1 0 10000000000)'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Fix Eclipse permissions issue (https://stackoverflow.com/a/71740449/388827)
alias fixeclipse="sudo codesign --force --deep --sign - '/Applications/Eclipse RCP.app'"

# https://www.metachris.com/2024/01/terminal-and-bash-tips-tricks/

# Show / copy SSH pubkey
alias pubkey="cat ~/.ssh/id_rsa.pub"
alias pubkeycopy="cat ~/.ssh/id_rsa.pub | pbcopy"

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Show IP
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# ######
# prompt
# ######

# TODO

# ######
# colors
# ######

export CLICOLOR=1

# this works better with dark windows
# https://apple.stackexchange.com/a/33679/93024
# export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# export LSCOLORS=xxfxcxdxbxegedabagacad

# ################################################
# end -- lines below have been added automatically
# ################################################

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home

export PATH="$HOME/.deno/bin:$PATH"
