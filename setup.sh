#!/usr/bin/env bash
set -eux

finish() {
	 # do stuff
   # exit traps! holy shit!
	echo "finishing..."
};

trap finish EXIT INT TERM

OS=$(lsb_release -rs)

force_ln_s() {
  # if the file doesn't exist, link it; otherwise backup the old file and link it
	if ! [ -f $2 ]; then
		ln -s $1 $2
	else
		echo "BACKUP OLD RC $1, LINKING $2"
		mv $2 $2_bkup
		ln -s $1 $2
	fi
}

clone_git_repo() {
	local url=$1
	local folder=$2
	if [ ! -d "$folder" ] ; then
    git clone "$url" "$folder"
	else
		cd "$folder" && git pull
	fi
}

install_bazel_tools() {
  wget https://go.dev/dl/go1.17.8.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.8.linux-amd64.tar.gz
	rm go1.17.8.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin && go get github.com/bazelbuild/buildtools/buildifier
  export PATH=$PATH:/usr/local/go/bin && go get github.com/bazelbuild/bazelisk
}

install_cinnamon() {
  sudo apt update && sudo apt install cinnamon
}

install_docker() {
  sudo apt-get update
  sudo apt-get install -y \
	    ca-certificates \
	    curl \
	    gnupg \
	    lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

	sudo bash -c 'echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker $(whoami)
}

install_deps() {
  echo "Installing apt apps"
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y \
    autojump \
    binfmt-support \
    clang-format \
    curl \
    git \
		lsb-release \
    nfs-common \
    nmap \
    openssh-client \
    qemu \
		qemu-user-static \
    rsync \
    tmux \
    tree \
    vim \
    zsh
  # Make common directories
  sudo mkdir -p /opt/murt/data /mnt/freenas /mnt/laptop
  sudo chown 1000:1000 /opt/murt /mnt/freenas /mnt/laptop
}

configure_vim() {
  clone_git_repo https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
}

configure_zsh() {
	if [[ -d "$HOME/.oh-my-zsh" ]]; then
		echo "ZSH seemingly already installed. Skipping..."
		return 0
	fi
	sudo chsh --shell $(which zsh) $(whoami)
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	clone_git_repo https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
	clone_git_repo https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	clone_git_repo https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  # https://medium.com/@christyjacob4/powerlevel9k-themes-f400759638c2
  wget --directory-prefix="$HOME"/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
}


install_icons() {
  # https://www.ravefinity.com/p/vivacious-colors-gtk-icon-theme.html
  sudo add-apt-repository -y ppa:ravefinity-project/ppa
  sudo apt-get update
  sudo apt-get install vivacious-colors
}

symlink_dotfiles() {
  echo "this will set up dot files to their symlinks"
  #DIR=`pwd`
  DIR=$HOME/murt/dotfiles
  echo "using DIR=$DIR"

  # These are commonly installed by packages. Force the symlink by backing up existing files first if
  # the exist
  force_ln_s "$DIR/bash/bashrc" "$HOME/.bashrc"
  force_ln_s "$DIR/zsh/zshrc" "$HOME/.zshrc"
  force_ln_s "$DIR/vim/vimrc" "$HOME/.vimrc"
  force_ln_s "$DIR/git/gitconfig" "$HOME/.gitconfig"
  force_ln_s "$DIR/bash/aliases" "$HOME/.aliases"

  if ! [ -f "$HOME/.environment" ]; then ln -s $DIR/bash/environment $HOME/.environment; fi
  if ! [ -f "$HOME/.devpaths" ]; then ln -s $DIR/bash/devpaths $HOME/.devpaths; fi
  if ! [ -f "$HOME/.dockerfuncs" ]; then ln -s $DIR/docker/dockerfuncs $HOME/.dockerfuncs; fi
  if ! [ -f "$HOME/.tmux.conf" ]; then ln -s $DIR/tmux/tmux.conf $HOME/.tmux.conf; fi
  if ! [ -f "$HOME/.pythonrc" ]; then ln -s $DIR/python/pythonrc $HOME/.pythonrc; fi
}

install_python() {
	sudo apt install -y python3 python3-venv
}

install_rust() {
	curl https://sh.rustup.rs -sSf | sh
}


install_flatpak() {
  echo "Installing flatpak and flatpak apps"
	# Flatpak is available in 19.04 via apt without need for ppa.
  sudo apt install -y flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # Spotify, music app
  flatpak install -y flathub com.spotify.Client
  # Discord, gaming/voice/messaging app
  flatpak install -y flathub com.discordapp.Discord
  # Slack, messaging app
  flatpak install -y flathub com.slack.Slack
  # Natron, compositing app
  flatpak install -y flathub fr.natron.Natron
  # Atom, text editor
  flatpak install -y flathub io.atom.Atom
  # Signal, messaging app
  flatpak install -y flathub org.signal.Signal
  # Blender, 3d modeling
  flatpak install -y flathub org.blender.Blender
  # GIMP, photo editing
  flatpak install -y flathub org.gimp.GIMP
}

install_tilix () {
  sudo apt install -y tilix
}

#TODO(curtismuntz): Add install keybase support!
#install_keybase {
#	curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
#	# if you see an error about missing `libappindicator1` from the next
#	# command, you can ignore it, as the subsequent command corrects it
#	sudo dpkg -i keybase_amd64.deb
#	sudo apt-get install -f
#	run_keybase
#}

install_tools() {
  # Find replacement
  # install fd: https://github.com/sharkdp/fd
  wget --directory-prefix=/tmp https://github.com/sharkdp/fd/releases/download/v8.3.2/fd_8.3.2_amd64.deb
  sudo dpkg -i /tmp/fd_8.3.2_amd64.deb

  # cat replacement
  # bat: https://github.com/sharkdp/bat
  wget --directory-prefix=/tmp https://github.com/sharkdp/bat/releases/download/v0.20.0/bat_0.20.0_amd64.deb
  sudo dpkg -i /tmp/bat_0.20.0_amd64.deb

  # ls replacement
  wget --directory-prefix=/tmp https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_amd64.deb
  sudo dpkg -i /tmp/lsd_0.21.0_amd64.deb
}

## MAIN
if [ $(id -u) = 0 ]; then
  echo "Do not run this as root"
  exit 1
fi

if [ ! -f ~/.ssh/id_rsa.pub ]; then
  echo "ssh key not found!"
  echo "create an ssh key and upload it to github/lab before proceeding."
  exit 1
fi

# ALWAYS INSTALL:
install_deps
install_bazel_tools
install_tools
install_python
install_rust
configure_vim
configure_zsh
symlink_dotfiles

# CONDITIONALLY INSTALL:
# Only apps if not on crostini
if [[ $(hostname) != "penguin" ]]; then
  install_docker
  install_flatpak
  install_tilix
  install_cinnamon
  install_icons
fi

#TODO(curtismuntz): Add installers for:
# virtualbox install
# keybase install
# dropbox install
echo "DONE! You may want to reboot..."
