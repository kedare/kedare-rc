#!/bin/env bash
FILES="tmux.conf"
HERE=`pwd`
OS=`uname`

## VIM
curl -sLf https://spacevim.org/install.sh | bash

## EMACS
echo "EMACS: Install SpaceEmacs\r\n"
cd ~
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd $HERE

## ASDF
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
echo "source ~/.asdf/asdf.fish" > ~/.config/fish/conf.d/asdf.fish
source ~/.asdf/asdf.fish
asdf plugin install python
asdf plugin install golang
asdf plugin install nodejs


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

