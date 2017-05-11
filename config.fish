## Aliase

set local_pre ~/.config/fish/config.pre.fish
set local_post ~/.config/fish/config.post.fish 

if test -e $local_pre  
  source $local_pre
end

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

## Pyenv configuration
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PATH
pyenv rehash
status --is-interactive; and source (pyenv init -|psub)

### GO
set -x GOPATH ~/Go
set -x PATH ~/Go/bin/ $PATH

### Git configuration
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  set_color normal
end

if test -e $local_post
  source $local_post
end
