#!/bin/bash

set -e

sudo apt build-dep -y emacs
sudo apt install -y libgnutls28-dev libwebkit2gtk-4.0-dev mailutils libgccjit-10-dev libjansson-dev 

cd ~/Downloads
git clone git://git.savannah.gnu.org/emacs.git -b feature/native-comp
cd emacs
./autogen.sh
./configure --with-native-compilation --with-x-toolkit=gtk3 --with-cairo --with-xwidgets --with-json
make -j$((`nproc`+1))
sudo make install
git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
