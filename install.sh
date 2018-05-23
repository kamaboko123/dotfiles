#!/bin/sh

DIR=$(readlink -f $(cd $(dirname $0);pwd))

#.vimrc
echo "install : .vimrc"
unlink ~/.vimrc
ln -s $DIR/.vimrc ~/.vimrc

echo "install : .tmux.conf"
unlink ~/.tmux.conf
ln -s $DIR/.tmux.conf ~/.tmux.conf

