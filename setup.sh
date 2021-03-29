#!/bin/bash -i

set -e

function install_desktop {
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
}

function install_vm {
    sudo apt install -y virtualbox
    sudo apt install -y ssh
    sudo apt install -y filezilla
    sudo apt install -y virtualbox
    sudo apt install -y virtualbox-guest-additions-iso
}

function install_password {
    sudo apt install -y keepassxc
    sudo apt install -y nautilus-dropbox
}

function install_creative {
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
}

function install_math {
    flatpak install org.geogebra.GeoGebra

    sudo apt install -y wxmaxima
    sudo apt install -y xcas
}

function install_office {
    sudo apt install -y scribus
    sudo apt install -y pdfarranger
    sudo apt install -y ubuntustudio-fonts
}

function install_terminal {
    sudo apt install -y neovim
    sudo apt install -y tmux
    sudo apt install -y traceroute
    sudo apt install -y build-essential
}

function install_node {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
    source ~/.bashrc
    nvm install node
}

function install_emacs {
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
    ./configure --with-native-compilation --with-json
    make -j$((`nproc`+1))
    sudo make install

    git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

    popd
    cp .spacemacs ~

    # Compile everything else
    echo "Opening emacs for the first time to install packages"
    emacs

    systemctl --user enable emacs.service
    systemctl --user start emacs.service
}

function install_writing {
    sudo apt install -y default-jre
    sudo apt install -y texlive-full

    pushd ~/.emacs.d/private
    curl -L https://raw.githubusercontent.com/languagetool-org/languagetool/master/install.sh | bash
    popd
}

function print_message {
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
    echo "run emacs via emacsclient"
    echo "Check languagetool path"
    echo "Set up firewall"
}

function help {
    echo "install            Install all personal settings"
    echo "install_desktop    Install desktop packages"
    echo "install_vm         Install virtual machine"
    echo "install_password   Install password setup"
    echo "install_creative   Install creative packages"
    echo "install_math       Install math packages"
    echo "install_office     Install office packages"
    echo "install_terminal   Install terminal apps"
    echo "install_node       Install nodejs"
    echo "install_emacs      Install emacs"
    echo "install_writing    Install emacs writing settings"
}

if [[ $# -eq 0 ]]
then
    help
fi

case $1 in
    install)
        install_desktop
        install_vm
        install_password
        install_creative
        install_math
        install_office
        install_terminal
        install_node
        install_emacs
        install_writing
        print_message
        ;;
    install_desktop)
        install_desktop
        ;;
    install_vm)
        install_vm
        ;;
    install_password)
        install_password
        ;;
    install_creative)
        install_creative
        ;;
    install_math)
        install_math
        ;;
    install_office)
        install_office
        ;;
    install_terminal)
        install_terminal
        ;;
    install_node)
        install_node
        ;;
    install_emacs)
        install_emacs
        ;;
    install_writing)
        install_writing
        ;;
esac
