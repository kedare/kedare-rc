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
plugins=(tmux postgres perl git ruby rvm python cp docker emacs node npm nvm zsh-syntax-highlighting alias-tips)

# User configuration
source $ZSH/oh-my-zsh.sh

# I want English
export LANG=en_US.UTF-8

# Aliases
alias e="emacsclient -t"
export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nv
