#!/bin/env bash
FILES="xonshrc vimrc tmux.conf spacemacs"
HERE=`pwd`
OS=`uname`

## VIM
echo "VIM: Installing Plug\r\n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd $HERE

echo "VIM: Symlinks for NVIM compat"
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim


## EMACS
echo "EMACS: Install SpaceEmacs\r\n"
cd ~
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd $HERE


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

## FISH
mkdir -p ~/.config/fish/
cp config.fish ~/config/fish/

# Fish Kubernetes completion
mkdir -p ~/.config/fish/completions
cd ~/.config/fish
git clone https://github.com/evanlucas/fish-kubectl-completions
ln -s ../fish-kubectl-completions/kubectl.fish completions/
