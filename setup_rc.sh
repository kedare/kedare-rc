#!/bin/env bash
FILES="zshrc xonshrc vimrc tmux.conf spacemacs ansible.cfg"
HERE=`pwd`
OS=`uname`

## VIM
curl -sLf https://spacevim.org/install.sh | bash

## EMACS
echo "EMACS: Install SpaceEmacs\r\n"
cd ~
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd $HERE

# ZSH
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# PyEnv Installer
curl https://pyenv.run | bash

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

