#!/bin/bash

set -e

sudo apt install -y fonts-firacode

sudo apt build-dep -y emacs
sudo apt install -y libgnutls28-dev libwebkit2gtk-4.0-dev mailutils libgccjit-10-dev libjansson-dev 

# Change after feature/native-comp is in master
# You can consider merging with master here too
# In master --with-cairo is not needed

cd ~/Downloads
git clone git://git.savannah.gnu.org/emacs.git 
cd emacs
git checkout feature/native-comp
./autogen.sh
./configure --with-native-compilation --with-x-toolkit=gtk3 --with-cairo --with-xwidgets --with-json
make -j$((`nproc`+1))
sudo make install

git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo "Give spacemacs some time to compile everything"
emacs

systemctl --user enable emacs.service
systemctl --user start emacs.service

echo "Run spacemacs via the emacsclient"
