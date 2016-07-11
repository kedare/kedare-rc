if [ -f ~/.zshrc.pre.local ]; then
  source ~/.zshrc.pre.local
fi

# Attach tmux before anything else
if [ -z $TMUX ]; then
    tmux -u -2 attach
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Favorite theme
#ZSH_THEME="agnoster"
#ZSH_THEME="jnrowe"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Force term
export TERM="screen-256color" 

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# More logical timestamps
HIST_STAMPS="dd/mm/yyyy"

# ZSH Plugins
plugins=()

# Shell
plugins+=(sudo history tmux cp rsync zsh-syntax-highlighting alias-tips nice-exit-code)

# Versionning
plugins+=(git svn k)

# Editors
plugins+=()

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

# System tools
plugins+=(docker)

os=`uname`
if [[ $os == "Darwin" ]]; then
  plugins+=(brew brew-cask osx)
elif [[ $os == "Linux" ]]; then
  plugins+=(debian)
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

if [ -f ~/.zshrc.post.local ]; then
  source ~/.zshrc.post.local
fi
