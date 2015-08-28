#!/bin/env bash
FILES="zshrc vimrc tmux.conf"
HERE=`pwd`
OS=`uname`

echo -e "ZSH: Install oh-my-zsh\r\n"
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh/

echo -e "ZSH: Install zsh-syntax-highlighting\r\n"
git clone --depth=1 git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo -e "ZSH: Install alias-tips"
git clone --depth=1 https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

echo -e "ZSH: Installing zsh-completions"
git clone --depth=1 https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions

echo -e "ZSH: Installing zaw"
git clone --depth=1 https://github.com/zsh-users/zaw/ ~/.oh-my-zsh/custom/plugins/zaw

echo "VIM: Installing Neobudle\r\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh)"
cd $HERE

echo "EMACS: Install .emacs.d\r\n"
cd ~
git clone --depth=1 https://github.com/mathieupoussin/emacs-rc.git .emacs.d
cd $HERE

echo -e "Installing custom RC\r\n"
for new_file in $FILES; do
  backup_file=~/bkp_$new_file
  echo -e "Processing $new_file"
  mv ~/.$new_file $backup_file &> /dev/null # Old files may not exist
  bzip2 --best $backup_file &> /dev/null # Old files may not exist
  cp -r $new_file ~/.$new_file
done
cd $HERE
