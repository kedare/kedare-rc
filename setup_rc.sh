#!/bin/env bash
FILES="tmux.conf bashrc zshrc"
HERE=$(pwd)
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "${machine}"

## VIM
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

## EMACS
echo "EMACS: Install SpaceEmacs\r\n"
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

## ZSH
git clone https://github.com/ohmyzsh/ohmyzsh ~/.oh-my-zsh

## ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
source $HOME/.asdf/asdf.sh
asdf plugin add python
asdf plugin add golang
asdf plugin add nodejs
asdf plugin add ruby
asdf plugin add erlang
asdf plugin add elixir

# Go
asdf install golang 1.18.5
asdf global golang 1.18.5
asdf reshim
go install github.com/charmbracelet/gum@latest
go install github.com/nao1215/gup@latest

## TMUX
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh
bash /tmp/rustup.sh --no-modify-path -y --profile complete

## Dot RC files
echo -e "Installing custom RC\r\n"
for new_file in $FILES; do
  backup_file=~/bkp_$new_file
  echo -e "Processing $new_file"
  mv ~/.$new_file $backup_file &> /dev/null # Old files may not exist
  bzip2 --best $backup_file &> /dev/null # Old files may not exist
  cp -r $new_file ~/.$new_file
done
cd $HERE

