#!/bin/sh

DIR=$(readlink -f $(cd $(dirname $0);pwd))

#.vimrc
echo "install : .vimrc"
unlink ~/.vimrc
ln -s $DIR/.vimrc ~/.vimrc

