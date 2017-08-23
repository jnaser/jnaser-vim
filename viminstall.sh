#!/bin/bash
#Installation of VIM from Source

echo "Updating..."

sudo apt update
sudo apt upgrade

echo "Installing Dependencies..."

sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
            libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
                python3-dev ruby-dev lua5.1 lua5.1-dev git

echo "Removing old VIM..."

sudo apt-get remove vim-tiny vim-common vim-gui-common vim-nox

echo "Setting Locales..."

sudo export LANGUAGE=en_US.UTF-8
sudo export LANG=en_US.UTF-8
sudo export LC_ALL=en_US.UTF-8
sudo locale-gen en_US.UTF-8 
sudo dpkg-reconfigure locales

cd ~/
git clone https://github.com/vim/vim.git
cd ~/vim

echo "Configuring..."

./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp \
                --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
                --enable-python3interp \
                --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
                --enable-luainterp \
                --enable-gui=gtk2 --enable-cscope --prefix=/usr

echo "Making Runtime Directory..."

make VIMRUNTIMEDIR=/usr/share/vim/vim80

echo "Installing..."

sudo make install

echo "Installing Color Scheme..."

mkdir -p ~/.vim/colors && cd ~/.vim/colors
wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

echo "Installing CURL..."

sudo apt-get install curl

echo "Installing Pathogen..."

mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Installing Plugins..."
cd ~/.vim/bundle
git clone git://github.com/Lokaltog/vim-powerline.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/klen/python-mode
git clone git://github.com/davidhalter/jedi-vim.git
git clone git://github.com/tpope/vim-fugitive.git
git clone https://github.com/scrooloose/nerdtree.git

vim -u NONE -c "helptags vim-fugitive/doc" -c q

echo "Updating Jedi..."

cd ~/.vim/bundle/jedi-vim
git submodule update --init

echo "Installing Ftplugin..."

mkdir -p ~/.vim/ftplugin
wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492

echo "Getting Config..."
wget -P ~/ https://github.com/jnaser/jnaser-vim/blob/master/.vimrc

echo "Configuring Plugins.."
vim -u NONE -c "helptags vim-fugitive/doc" -c q

echo "Installation is finished, please load your .vimrc file to ~/"

