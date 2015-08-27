#!/bin/env bash
FILES="zshrc vimrc tmux.conf"

echo -e "This will backup your current files and copy new files to your home.\r\n"
read -p "Press any key to continue... " -n1 -s

for new_file in $FILES; do
  backup_file=~/bkp_$new_file
  echo -e "Processing $new_file"
  mv ~/.$new_file $backup_file
  bzip2 --best $backup_file
  cp -r $new_file ~/.$new_file
done
