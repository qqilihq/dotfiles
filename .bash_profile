# ####
# path
# ####

export PATH="$HOME/bin:$PATH"

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

# -l long format
# -a include . directories
# -F additional characters for type (e.g. `/` after dir)
# -h human-readable units
alias ll='ls -laFh'

alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'

# fix duplicate entries in the Finder’s “Open With” menu
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; killall Finder'

# refresh shell
alias reload='source ~/.bash_profile'


# ######
# prompt
# ######

# https://github.com/necolas/dotfiles/blob/master/shell/bash_prompt
# https://github.com/mathiasbynens/dotfiles/blob/master/.bash_prompt
prompt_git() {
  local s='';
  local branchName='';

  # Check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

      # Ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null;

      # Check for uncommitted changes in the index.
      if ! $(git diff --quiet --ignore-submodules --cached); then
        s+='+';
      fi;

      # Check for unstaged changes.
      if ! $(git diff-files --quiet --ignore-submodules --); then
        s+='!';
      fi;

      # Check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s+='?';
      fi;

      # Check for stashed files.
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        s+='$';
      fi;

    fi;

    # Get the short symbolic ref.
    # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
    # Otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      echo '(unknown)')";

    [ -n "${s}" ] && s=" [${s}]";

    echo -e "${1}${branchName}${2}${s} ";
  else
    return;
  fi;
}

prompt_command() {
  local EXIT="$?"
  # https://misc.flogisoft.com/bash/tip_colors_and_formatting
  local DIM='\e[2m'
  local LIGHT_RED='\e[91m'
  local RESET_ALL='\e[0m'
  # set tab/window title
  PS1='\[\033]0;\w\007\]'
  # Git info (if applicable), and current directory
  PS1+="\$(prompt_git)${DIM}\w \$${RESET_ALL} "
  # show exit code in case last command was no successful
  # https://stackoverflow.com/questions/16715103/bash-prompt-with-last-exit-code
  if [ $EXIT != 0 ]; then
    PS1="${LIGHT_RED}${EXIT}${RESET_ALL} ${PS1}"
  fi
}
export PROMPT_COMMAND=prompt_command


# ######
# colors
# ######

export CLICOLOR=1

# this works better with dark windows
# https://apple.stackexchange.com/a/33679/93024
# export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LSCOLORS=xxfxcxdxbxegedabagacad

# ####
# misc
# ####

# allows to actually append history when running multiple shells
shopt -s histappend

# use VS Code as the default editor
export EDITOR='code -w'

# git tab completion -- use `brew install git bash-completion`
# https://stackoverflow.com/a/14970926/388827
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# ################################################
# end -- lines below have been added automatically
# ################################################
