#!/bin/bash

# Get dotfile directory
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Update submodules
git submodule update --init --remote

# vim
ln -s ${BASEDIR}/.vimrc ~/.vimrc
ln -s ${BASEDIR}/.vim ~/.vim

# zsh
ln -s ${BASEDIR}/.zshrc ~/.zshrc

# git
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig
ln -s ${BASEDIR}/.gitignore ~/.gitignore 

# Karabiner Elements
mkdir -p ~/.config/karabiner
ln -s ${BASEDIR}/karabiner.json ~/.config/karabiner/karabiner.json 
