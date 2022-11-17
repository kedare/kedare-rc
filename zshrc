# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

TERM="xterm-256color"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  golang
  postgres
  github
  nmap
  sudo
  tmux
  python
  ansible
  alias-finder
  colored-man-pages
  command-not-found
  cp
  asdf
  macos
  brew
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export EDITOR=nvim

alias zshconfig="nvim $HOME/.zshrc"
alias y2mp3="youtube-dl -x --audio-format mp3 --xattrs --audio-quality 7 --add-metadata --embed-thumbnail"
alias gco="git commit"
alias gcam="git commit -am"
alias gps="git push"
#alias gpsu='git push -u origin $(git branch --show-current)'
alias gpl="git pull"
alias gs="git status"
alias glg="git log"
alias ga="git add"
alias gaa="git add -A"
alias gcl="git clone"
alias gd="git diff"
alias gdc="git diff --cached"
alias gcs="git clone --depth=1"
alias gcam="git commit -am"
alias gca="git add -A"
alias ggc="git gc --force --aggressive"
alias e="emacsclient -t"
alias edm="emacs --daemon"
alias vim="nvim"
alias aras="ara-manage runserver"
alias tf="terraform"
alias cat="bat"
alias wt='watch -n1 $(fc -ln -1)'
alias k="kubectl"

# Own .bin
export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

# Rust / Cargo
export PATH="$HOME/.cargo/bin:$PATH"
alias lsx="exa -lha --git"
alias update-rust-tools="rustup update; cargo install --locked starship exa bat ripgrep fd-find procs sd tealdeer tokei du-dust grex git-delta difftastic"

# Go
export PATH="$HOME/go/bin:$PATH"
export GOFLAGS="-v"

eval "$(starship init zsh)"

function gpsu {
  STASH_ALL=$(gum confirm "Stash all?")
  TITLE=$(gum input --placeholder "Commit title")
  DESCRIPTION=$(gum write --placeholder "Commit text")
  if [[ $STASH_ALL -eq "0" ]]
  then
    git add -A
  fi
  git commit -m "$TITLE" -m "$DESCRIPTION"

  REMOTE_BRANCH_EXISTS=$(git ls-remote origin $(git branch --show-current) | wc -l)
  if [[ $REMOTE_BRANCH_EXISTS -eq "0" ]]
  then
    gum confirm "Push new branch?" && git push -u origin $(git branch --show-current)
  else
    git push
  fi
}

source $HOME/.zshrc.post
