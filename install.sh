#!/bin/bash

if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
cp ./_vimrc ~/.vimrc
vim +PluginInstall +qall
