# Attach tmux before anything else
tmux -u -2 attach

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Favorite theme
ZSH_THEME="agnoster"

# Force term
export TERM=xterm-256color

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# More logical timestamps
HIST_STAMPS="dd/mm/yyyy"

# ZSH Plugins
plugins=()

# Shell
plugins+=(sudo history tmux cp rsync zsh-syntax-highlighting alias-tips zaw)

# Versionning
plugins+=(git svn)

# Editors
plugins+=(emacs)

# Databases
plugins+=(postgres)

# Ruby
plugins+=(ruby rvm gem bundler rake)

# NodeJS / Javascript
plugins+=(node npm nvm meteor jsontool)

# Python
plugins+=(python pep8 django)

# Perl
plugins+=(perl cpan)

os=`uname`
if [[ $os == "Darwin" ]]; then
  plugins+=(brew brew-cask osx)
elif [[ $os == "Linux" ]]; then
  plugins+=(docker debian)
fi

# User configuration
source $ZSH/oh-my-zsh.sh

# Bind C-Q C-Q to zaw
bindkey '^Q^Q' zaw

# I want English
export LANG=en_US.UTF-8

# Aliases
alias e="emacsclient -t"
export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
