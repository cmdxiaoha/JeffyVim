#!/bin/bash

if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

cp ./_vimrc ~/.vimrc
cp ./_ycm_extra_conf.py ~/.ycm_extra_conf.py
cp -r ./bin ~/.vim/

vim +PluginInstall +qall

