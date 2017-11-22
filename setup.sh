#! /bin/bash
finish() {
	 # do stuff
   # exit traps! holy shit!
	echo "finishing..."

 };
trap finish EXIT INT TERM

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
