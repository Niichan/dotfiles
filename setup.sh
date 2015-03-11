#!/bin/bash -xe

# Sanity check / setup
cd /home/xena
mkdir code

# Clone dotiles
git clone https://github.com/Xe/dotfiles code/dotfiles

# setlink sets a symlink to my dotfiles repo for the correct file.
function setlink
{
        ln -s $HOME/code/dotfiles/$1 $HOME/$1
}

# set links
setlink .zshrc
setlink .zsh
setlink .vim
setlink .vimrc
setlink .gitconfig
setlink .tmux.conf

export GOPATH=/home/xena/go
export PATH=/usr/local/go/bin:$PATH

# Golang stuff
(mkdir -p ~/go/{pkg,bin,src})
go get github.com/mattn/todo
go get github.com/motemen/ghq
go get github.com/Xe/tools/...

# Setup vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set up vim plugins
head -n 40 ~/.vimrc >> ~/.vimrc-temp
vim -u ~/.vimrc-temp +PluginInstall +qall
rm ~/.vimrc-temp

# Binary extensions for vim
(cd ~/.vim/bundle/YouCompleteMe; ./install.sh --clang-completer)
(cd ~/.vim/bundle/vimproc.vim; make)
vim +GoInstallBinaries +qall

echo "Set up!"
