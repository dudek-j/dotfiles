#!/bin/bash

# Get dotfile directory
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew bundle ${BASEDIR}/.Brewfile

# Update submodules
git submodule update --init --remote

# vim
ln -s ${BASEDIR}/.vimrc ~/.vimrc
ln -s ${BASEDIR}/.vim ~/.vim

# zsh
ln -s ${BASEDIR}/.zshrc ~/.zshrc
ln -s ${BASEDIR}/.oh-my-zsh ~/.oh-my-zsh

# git
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig
ln -s ${BASEDIR}/.gitignore ~/.gitignore 

# Karabiner Elements
mkdir -p ~/.config/karabiner
ln -s ${BASEDIR}/karabiner.json ~/.config/karabiner/karabiner.json 
