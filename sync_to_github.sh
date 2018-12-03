#!/bin/sh
set -e

usage() {
  echo "Usage:"
  echo "$0 \$TARGET"
  echo "$0 third_party"
  exit
}

target=$1
github_username=curtismuntz
gitlab_username=murtis
sync_commit="Sync to github from https://gitlab.com/murtis/$target"

if [ ! -d "$target" ]; then
  echo "target $target does not exist in current directory."
  exit 1
fi

cd $target
git remote set-url origin git@github.com:"$github_username"/"$target".git
git push origin master -f
git remote set-url origin git@gitlab.com:"$gitlab_username"/"$target".git
