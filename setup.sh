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
DIR=$HOME/murt/dotfiles
echo "using DIR=$DIR"
force_symlink_arg1TARGET_argLINKNAME "$DIR/bash/bashrc" "$HOME/.bashrc"
force_symlink_arg1TARGET_argLINKNAME "$DIR/zsh/zshrc" "$HOME/.zshrc"
force_symlink_arg1TARGET_argLINKNAME "$DIR/vim/vimrc" "$HOME/.vimrc"
force_symlink_arg1TARGET_argLINKNAME "$DIR/git/gitconfig" "$HOME/.gitconfig"
force_symlink_arg1TARGET_argLINKNAME "$DIR/git/gitconfig" "$HOME/.gitconfig"
force_symlink_arg1TARGET_argLINKNAME "$DIR/bash/aliases" "$HOME/.aliases"

if ! [ -f "$HOME/.environment" ]; then ln -s $DIR/bash/environment $HOME/.environment; fi
if ! [ -f "$HOME/.devpaths" ]; then ln -s $DIR/bash/devpaths $HOME/.devpaths; fi
if ! [ -f "$HOME/.dockerfuncs" ]; then ln -s $DIR/docker/dockerfuncs $HOME/.dockerfuncs; fi
if ! [ -f "$HOME/.bazelrc" ]; then ln -s $DIR/bazel/bazelrc $HOME/.bazelrc; fi

# Make a directory for vim persistent undo
mkdir -p $HOME/.undodir
