#!/usr/bin/env python3

import git
import sys
import os
import filecmp
from absl import app
from absl import flags
from absl import logging

FLAGS = flags.FLAGS
flags.DEFINE_string("github_username", None, "username for github account sync")
flags.DEFINE_string("gitlab_username", None, "username for gitlab account sync")
flags.DEFINE_string("repo", None, "repository name")

flags.mark_flag_as_required("github_username")
flags.mark_flag_as_required("gitlab_username")
flags.mark_flag_as_required("repo")

def modify_readme(source_repo):
    data = "This repository is a mirror of https://gitlab.com/" + FLAGS.gitlab_username + "/" + FLAGS.repo + "\n"
    readme_file = os.path.join(source_repo,'README.md')
    if data == open(readme_file).read():
        return False
    else:
        with open(readme_file, 'w') as output:
            output.write(data)
        return True


def commit_and_push_to_github(repo):
    SYNC_MESSAGE="Sync from mirror: https://gitlab.com/" + FLAGS.gitlab_username + "/" + FLAGS.repo
    GITHUB_URL="git@github.com:" + FLAGS.github_username + "/" + FLAGS.repo + ".git"
    GITLAB_URL="git@gitlab.com:" + FLAGS.gitlab_username + "/" + FLAGS.repo + ".git"
    repo.git.checkout('sync_from_gitlab')
    # try:
    #     repo.git.rebase('master')
    # except:
    #     pass
    # git rebase -X theirs branch-b
    # repo.git.rebase('-X theirs master')
    # repo.git.merge('-X ours master')
    repo.git.merge("master")
    modify_readme(os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])), FLAGS.repo))
    repo.git.add('README.md')
    repo.git.commit(m=str(SYNC_MESSAGE))
    remote = git.Remote(repo,"origin")
    remote.set_url(GITHUB_URL)
    remote.push('sync_from_gitlab')
    repo.git.checkout('master')
    remote.set_url(GITLAB_URL)



def main(argv):
    repo = git.Repo(FLAGS.repo)

    if repo.is_dirty():
        print("Repo is dirty. exiting.")
        return 0

    commit_and_push_to_github(repo)

    return 0


if __name__ == "__main__":
    app.run(main)
