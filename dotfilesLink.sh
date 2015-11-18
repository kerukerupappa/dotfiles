#!/bin/sh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc
ln -sf ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

git config --global core.excludesfile ~/.gitignore_global
git config --global diff.excludesfile ~/dotfiles/.git_diff_wrapper
git config --global diff.tool vimdiff
