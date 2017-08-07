#! /bin/bash
finish() {
	 # do stuff
   # exit traps! holy shit!
	echo "finishing..."

 };
trap finish EXIT INT TERM

force_symlink_arg1TARGET_argLINKNAME() {
	if ! [ -f $2 ]; then
		ln -s $1 $2
	else
		echo "REMOVING OLD RC $1, LINKING $2"
		rm $2
		ln -s $1 $2
	fi
}

echo "this will set up dot files to their symlinks"
#DIR=`pwd`
DIR=~/murt/dotfiles
echo "using DIR=$DIR"
force_symlink_arg1TARGET_argLINKNAME "$DIR/bash/bashrc" "~/.bashrc"
force_symlink_arg1TARGET_argLINKNAME "$DIR/zsh/zshrc" "~/.zshrc"
force_symlink_arg1TARGET_argLINKNAME "$DIR/vim/vimrc" "~/.vimrc"
force_symlink_arg1TARGET_argLINKNAME "$DIR/git/gitconfig" "~/.gitconfig"
force_symlink_arg1TARGET_argLINKNAME "$DIR/git/gitconfig" "~/.gitconfig"
force_symlink_arg1TARGET_argLINKNAME "$DIR/bash/aliases" "~/.aliases"

if ! [ -f "~/.environment" ]; then ln -s $DIR/bash/environment ~/.environment; fi
if ! [ -f "~/.devpaths" ]; then ln -s $DIR/bash/devpaths ~/.devpaths; fi
if ! [ -f "~/.dockerfuncs" ]; then ln -s $DIR/docker/dockerfuncs ~/.dockerfuncs; fi
if ! [ -f "~/.bazelrc" ]; then ln -s $DIR/bazel/bazelrc ~/.bazelrc; fi

# Make a directory for vim persistent undo
mkdir -p ~/.undodir
