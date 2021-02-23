## Aliase

export LANG=en_US.utf8
export LC_TYPE=$LANG
export LC_CTYPE=$LANG

# Always run on TMUX
if set -q TMUX
else
  if type -q tmux
    tmux -2 -u attach
  end
end

# Download music from youtube
abbr -a y2mp3 youtube-dl -x --audio-format mp3 --xattrs --audio-quality 7 --add-metadata --embed-thumbnail

# GIt commits
abbr -a gco git commit

# Git commit everything with message
abbr -a gca git commit -am 

# Git push
abbr -a gps git push

# Git pull
abbr -a gpl git pull

# Git status
abbr -a gs git status

# Git log
abbr -a glg git log

# Git add
abbr -a ga git add

# Git add everything
abbr -a gaa git add -A

# Git clone
abbr -a gcl git clone

# Git diff
abbr -a gd git diff

# Git cached diff
abbr -a gdf git diff --cached

# Git clone faster, I don't care about the history
abbr -a gcf git clone --depth=1

# Emacs start daemon
abbr -a edmn emacs --daemon

# Emacs start client to daemon
abbr -a e emacsclient -t

# VIM replace with NeoVim
abbr -a vim nvim

# User .BIN directory
set -x PATH ~/.bin $PATH

## Rust/Cargo
set -x PATH ~/.cargo/bin $PATH

# Exa replaces ls
if type -q exa
  abbr -a ls exa
else
  echo "Failed to load exa (not in PATH)"
end

# ARA web ui for Ansible
abbr -a aras ara-manage runserver

### GO
set -x PATH ~/go/bin/ $PATH

