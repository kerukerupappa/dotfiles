#!/bin/sh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gvimrc ~/.gvimrc
ln -sf ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin

git config --global core.excludesfile ~/.gitignore_global
git config --global diff.excludesfile ~/dotfiles/.git_diff_wrapper
git config --global diff.tool vimdiff
git config --global color.ui auto
git config --global pager.log 'diff-highlight | less'
git config --global pager.show 'diff-highlight | less'
git config --global pager.diff 'diff-highlight | less'

