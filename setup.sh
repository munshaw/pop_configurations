#!/bin/bash -i

set -e

###########
# Desktop #
###########

sudo apt install -y gnome-shell-extensions
sudo apt install -y ubuntu-restricted-extras
sudo apt install -y hardinfo
sudo apt install -y mesa-utils
sudo apt install -y vlc
sudo apt install -y rhythmbox
sudo apt install -y epiphany-browser
sudo apt install -y cheese
sudo apt install -y gufw
sudo apt install -y obs-studio

###################
# Virtual Machine #
###################

sudo apt install -y virtualbox
sudo apt install -y ssh
sudo apt install -y filezilla
sudo apt install -y virtualbox
sudo apt install -y virtualbox-guest-additions-iso

############
# Password #
############

sudo apt install -y keepassxc
sudo apt install -y nautilus-dropbox

############
# Creative #
############

flatpak install com.github.libresprite.LibreSprite

flatpak install org.blender.Blender
pushd ~/Downloads
wget https://github.com/Radivarig/UvSquares/archive/master.zip -O UvSquares.zip

sudo apt install -y krita
sudo apt install -y gimp
sudo apt install -y inkscape
sudo apt install -y audacity
sudo apt install -y lmms
popd

########
# Math #
########

flatpak install org.geogebra.GeoGebra

sudo apt install -y wxmaxima
sudo apt install -y xcas

##########
# Office #
##########

sudo apt install -y scribus
sudo apt install -y pdfarranger
sudo apt install -y ubuntustudio-fonts

############
# Terminal #
############

sudo apt install -y neovim
sudo apt install -y tmux
sudo apt install -y traceroute
sudo apt install -y build-essential

##########
# NodeJS #
##########

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
source ~/.bashrc
nvm install node

#############
# Spacemacs #
#############

sudo apt install -y fonts-firacode

sudo apt build-dep -y emacs
sudo apt install -y libgnutls28-dev libwebkit2gtk-4.0-dev mailutils libgccjit-10-dev libjansson-dev 

pushd ~/Downloads
git clone git://git.savannah.gnu.org/emacs.git 
cd emacs
git checkout feature/native-comp
git checkout master
git merge feature/native-comp --no-commit
./autogen.sh
./configure --with-native-compilation --with-xwidgets --with-json
make -j$((`nproc`+1))
sudo make install

git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

popd
cp .spacemacs ~

# Compile everything else
echo "################"
echo "################"
echo "################"
echo "Opening emacs for the first time to install packages"
echo "Install Fira Code Symbol with M-x fira-code-mode-install-fonts"
emacs

# Run via emacsclient
systemctl --user enable emacs.service
systemctl --user start emacs.service

###########
# Writing #
###########

sudo apt install -y default-jre
sudo apt install -y texlive-full

pushd ~/.emacs.d/private
curl -L https://raw.githubusercontent.com/languagetool-org/languagetool/master/install.sh | bash
popd

############
# Messages #
############

echo "To create new keys:"
echo "Run: \`ssh-keygen -t ed25519 -C \"email@example.com\" \`"
echo "Run: \`gpg --full-generate-key # 4k RSA\`"
echo
echo "To import keys:"
echo "SSH Public: ~/.ssh/id_ed25519.pub"
echo "SSH Private: ~/.ssh/id_ed25519"
echo "GPG Public: \`gpg --import public.key\`"
echo "GPG Private: \`gpg --import private.key\`"
echo
echo "To configure:"
echo "Run: \` ssh-agent -s\`"
echo "Run: \`ssh-add ~/.ssh/id_ed25519\`"
echo "Run: \`gpg --list-keys\`"
echo "Run: \`git config --global user.signingkey <Key code>\`."
echo
echo "To export GPG:"
echo "Run: \`gpg --export --armor && gpg --export-secret-keys --armor\`"
echo
echo "Reminders:"
echo "Check languagetool path"
echo "Set up firewall"
