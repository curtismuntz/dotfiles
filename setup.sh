#! /bin/bash
finish() {
	 # do stuff
   # exit traps! holy shit!
	echo "finishing..."

 };
trap finish EXIT INT TERM

force_symlink_arg1TARGET_arg2SOURCE() {
	if ~ [ -f $1 ]; then
		ln -s $2 $1
	else
		echo "REMOVING OLD RC $1, LINKING $2"
		rm $1
		ln -s $1 $2
	fi
}

echo "this will set up dot files to their symlinks"
#DIR=`pwd`
DIR=$HOME/murt/dotfiles
echo "using DIR=$DIR"
force_symlink_arg1TARGET_arg2SOURCE "$HOME/.bashrc" "$DIR/bash/bashrc"
force_symlink_arg1TARGET_arg2SOURCE "$HOME/.zshrc" "$DIR/zsh/zshrc"
force_symlink_arg1TARGET_arg2SOURCE "$HOME/.vimrc" "$DIR/vim/vimrc"
force_symlink_arg1TARGET_arg2SOURCE "$HOME/.gitconfig" "$DIR/git/gitconfig"
force_symlink_arg1TARGET_arg2SOURCE "$HOME/.gitconfig" "$DIR/git/gitconfig"
force_symlink_arg1TARGET_arg2SOURCE "$HOME/.aliases" "$DIR/bash/aliases"

if ! [ -f "$HOME/.environment" ]; then ln -s $DIR/bash/environment ~/.environment; fi
if ! [ -f "$HOME/.devpaths" ]; then ln -s $DIR/bash/devpaths ~/.devpaths; fi
if ! [ -f "$HOME/.dockerfuncs" ]; then ln -s $DIR/docker/dockerfuncs ~/.dockerfuncs; fi
if ! [ -f "$HOME/.bazelrc" ]; then ln -s $DIR/bazel/bazelrc ~/.bazelrc; fi

# Make a directory for vim persistent undo
mkdir -p $HOME/.undodir
