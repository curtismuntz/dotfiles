#! /bin/bash
set -ex

finish() {
	 # do stuff
   # exit traps! holy shit!
	echo "finishing..."

 };
trap finish EXIT INT TERM

install_docker() {
	sudo apt-get install -y \
	    apt-transport-https \
	    ca-certificates \
	    curl \
	    software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	   $(lsb_release -cs) \
	   stable"
	sudo apt-get update
	sudo apt-get install -y docker-ce docker-compose
	sudo usermod -aG docker $(whoami)
}

install_deps() {
	echo "Installing apt apps"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get install -y \
		git \
		tree \
		fonts-hack-ttf \
		curl \
		zsh \
		openssh-client \
		nfs-common \
		nmap \
		vim \
		clang-format \
		python \
		python3 \
		python3-pip \
		python-pip \
		rsync
# To install tilix sudo add-apt-repository ppa:webupd8team/terminix
#		tilix

	install_docker

	sudo chsh --shell $(which zsh) $(whoami)

	echo "Installing snap apps"
	sudo snap install spotify
	# sudo snap install slack --classic
	sudo snap install discord
	# sudo snap install atom --classic

	echo "Install oh-my-zsh manually"
}

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

echo "this will set up dot files to their symlinks"
#DIR=`pwd`
DIR=$HOME/murt/dotfiles
echo "using DIR=$DIR"

if [ $(id -u) = 0 ]; then
   echo "Do not run this as root"
   exit 1
fi

install_deps

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
if ! [ -f "$HOME/.bazelrc" ]; then ln -s $DIR/bazel/bazelrc $HOME/.bazelrc; fi
if ! [ -f "$HOME/.tmux.conf" ]; then ln -s $DIR/tmux/tmux.conf $HOME/.tmux.conf; fi
if ! [ -f "$HOME/.pythonrc" ]; then ln -s $DIR/python/pythonrc $HOME/.pythonrc; fi
