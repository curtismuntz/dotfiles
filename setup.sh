#! /bin/bash
finish() {
	 # do stuff
   # exit traps! holy shit!
	echo "finishing..."

 };
trap finish EXIT INT TERM

echo "this will set up dot files to their symlinks"
DIR=`pwd`
if ! [ -f "$HOME/.bashrc" ]; then ln -s $DIR/bash/bashrc ~/.bashrc; fi
if ! [ -f "$HOME/.environment" ]; then ln -s $DIR/bash/environment ~/.environment; fi
if ! [ -f "$HOME/.aliases" ]; then ln -s $DIR/bash/aliases ~/.aliases; fi
if ! [ -f "$HOME/.devpaths" ]; then ln -s $DIR/bash/devpaths ~/.devpaths; fi
if ! [ -f "$HOME/.vimrc" ]; then ln -s $DIR/vim/vimrc ~/.vimrc; fi
if ! [ -f "$HOME/.zshrc" ]; then ln -s $DIR/zsh/zshrc ~/.zshrc; fi
if ! [ -f "$HOME/.gitconfig" ]; then ln -s $DIR/git/gitconfig ~/.gitconfig; fi
if ! [ -f "$HOME/.dockerfuncs" ]; then ln -s $DIR/docker/dockerfuncs ~/.dockerfuncs; fi
if ! [ -f "$HOME/.bazelrc" ]; then ln -s $DIR/bazel/bazelrc ~/.bazelrc; fi

# Make a directory for vim persistent undo
mkdir -p $HOME/.undodir

