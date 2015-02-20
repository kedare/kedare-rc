#!/bin/env bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
FILES=".vimrc .emacs .zshrc .tmux.conf"

echo -e "This will backup your current .vimrc and .tmux.conf and create symlink\r\nto the current repository location (${SCRIPTPATH}) so don't move it after you ran the script.\r\n"
read -p "Press any key to continue... " -n1 -s

for new_file in ${FILES}; do
  echo -e "Processing ${new_file}"
  #rm -rf ~/${new_file}
  #ln -s $SCRIPTPATH/${new_file} ~/${new_file}
done
