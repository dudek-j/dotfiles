#!/bin/bash

# Get dotfile directory
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/instl.sh)"
brew bundle --file ${BASEDIR}/Brewfile

# Update submodules
git submodule update --init --remote

# vim
ln -fs ${BASEDIR}/vimrc ~/.vimrc

# zsh
ln -fs ${BASEDIR}/zshrc ~/.zshrc

# git
ln -fs ${BASEDIR}/gitconfig ~/.gitconfig
ln -fs ${BASEDIR}/gitignore ~/.gitignore 

# tmux
ln -fs ${BASEDIR}/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Karabiner Elements
mkdir -p ~/.config/karabiner
ln -fs ${BASEDIR}/karabiner.json ~/.config/karabiner/karabiner.json 

# Kitty
ln -fs ${BASEDIR}/kitty ~/.config/

# NPM global scripts
npm i -g trash-cli pure-prompt
