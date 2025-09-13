#!/bin/env bash

# Configuration
export PATH=$HOME/.asdf/shims:$HOME/.local/bin:$PATH
FILES="tmux.conf bashrc zshrc wezterm.lua"
VERSION_GO=1.25.1
VERSION_NODEJS=23.8.0
VERSION_PYTHON=3.13.7
VERSION_RUBY=3.4.5
VERSION_NEOVIM=0.11.4
HERE=$(pwd)
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "${machine}"

## ZSH
git clone https://github.com/ohmyzsh/ohmyzsh ~/.oh-my-zsh

## ASDF
wget https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-amd64.tar.gz
tar -xvf asdf*.tar.gz
mkdir -p $HOME/.local/bin
mv asdf $HOME/.local/bin
asdf plugin add python
asdf plugin add golang
asdf plugin add nodejs
asdf plugin add ruby
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add neovim

asdf install golang $VERSION_GO
asdf set --home golang $VERSION_GO
asdf install nodejs $VERSION_NODEJS
asdf set --home nodejs $VERSION_NODEJS
asdf install ruby $VERSION_RUBY
asdf set --home ruby $VERSION_RUBY
asdf install neovim #$VERSION_NEOVIM
asdf set --home neovim $VERSION_NEOVIM

asdf reshim

## VIM
LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)

## EMACS
echo "EMACS: Install SpaceEmacs\r\n"
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

go install github.com/nao1215/gup@latest

## TMUX
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ZSH vim mode
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $HOME/.oh-my-zsh/plugins/zsh-vi-mode

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rustup.sh
bash /tmp/rustup.sh --no-modify-path -y

## Dot RC files
echo -e "Installing custom RC\r\n"
for new_file in $FILES; do
  backup_file=~/bkp_$new_file
  echo -e "Processing $new_file"
  mv ~/.$new_file $backup_file &> /dev/null # Old files may not exist
  bzip2 --best $backup_file &> /dev/null # Old files may not exist
  cp -r $new_file ~/.$new_file
done
cp starship.toml $HOME/.config/starship.toml
cd $HERE

