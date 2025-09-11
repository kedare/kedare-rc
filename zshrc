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
  zsh-vi-mode
  docker
  golang
  postgres
  github
  nmap
  tmux
  python
  ansible
  alias-finder
  colored-man-pages
  command-not-found
  cp
  macos
  brew
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export EDITOR=lvim

alias zshconfig="lvim $HOME/.zshrc"
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
alias gchm="git checkout \$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')"
alias gca="git add -A"
alias gcb="git checkout -b"
alias ggc="git gc --force --aggressive"
alias e="emacsclient -t"
alias edm="emacs --daemon"
alias vim="lvim"
alias aras="ara-manage runserver"
alias tf="terraform"
alias cat="bat"
alias wt='watch -n1 $(fc -ln -1)'
alias k="kubectl"

# Own .bin
export PATH="$HOME/.local/bin:$PATH"

# ASDF
export PATH="$HOME/.asdf/shims:$PATH"

# NodeJS / Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Rust / Cargo
export PATH="$HOME/.cargo/bin:$PATH"
alias lsx="exa -lha --git"
alias update-rust-tools="rustup update; cargo install --locked starship exa bat ripgrep procs sd tokei du-dust grex difftastic"

# Go
export PATH="$HOME/go/bin:$PATH"
export GOFLAGS="-v"

# BAT
export BAT_THEME="Visual Studio Dark+"

# Setup Starship
eval "$(starship init zsh)"

# Git push new branch
function gpsu {
  STASH_ALL=$(gum confirm "Stash all?")
  TITLE=$(gum input --placeholder "Commit title")
  DESCRIPTION=$(gum write --placeholder "Commit text")
  GIT_BRANCH=$(git branch --show-current)

  if [[ $GIT_BRANCH -eq "master" || $GIT_BRANCH -eq "dev" ]]
  then
    echo "Warning, don't push on master/dev"
    return
  fi

  if [[ $STASH_ALL -eq "0" ]]
  then
    git add -A
  fi
  git commit -m "$TITLE" -m "$DESCRIPTION"

  REMOTE_BRANCH_EXISTS=$(git ls-remote origin $GIT_BRANCH | wc -l)
  if [[ $REMOTE_BRANCH_EXISTS = "0" ]]
  then
    gum confirm "Push new branch?" && git push -u origin $(git branch --show-current)
  else
    git push
  fi
}

# Function to recursively find and perform git gc on repositories and report space regained
function git_gc_recursive() {
  # Find all directories named '.git' and iterate through their parent directories
  find . -type d -name ".git" | while read -r git_dir; do
    # Get the parent directory of the .git directory
    repo_path=$(dirname "$git_dir")

    echo "Processing repository: $repo_path"
    cd "$repo_path" || continue

    # Get disk usage before gc in bytes
    size_before_bytes=$(du -s .git | awk '{print $1}')

    # Run git gc
    echo "  Running 'git gc'..."
    git gc --quiet --aggressive --force

    # Get disk usage after gc in bytes
    size_after_bytes=$(du -s .git | awk '{print $1}')

    # Calculate space regained in bytes
    space_regained_bytes=$((size_before_bytes - size_after_bytes))

    # Convert bytes to a human-readable format
    function human_readable() {
      local bytes=$1
      local units=("B" "KB" "MB" "GB" "TB")
      local unit_index=0
      local size=$bytes

      while (( $(echo "$size >= 1024" | bc -l) )) && (( unit_index < 4 )); do
        size=$(echo "$size / 1024" | bc -l)
        ((unit_index++))
      done
      printf "%.2f %s\n" "$size" "${units[unit_index]}"
    }

    echo "  Space regained: $(human_readable "$space_regained_bytes")"

    echo "-----------------------------------"

    # Change back to the original directory to continue the search
    cd - >/dev/null
  done
}

touch $HOME/.zshrc.post
source $HOME/.zshrc.post

