#!/bin/sh

setup_git() {
  echo "Setting Git config ..."
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  echo "Making commit $TRAVIS_BUILD_NUMBER ..."
  git checkout -b auto-branch
  git add . contributors.md
  git add . requirements.txt
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  echo "Pushing to GitHub ..."
  git remote add origin https://${GITHUB_TOKEN}@github.com/cltk/cltk.git > /dev/null 2>&1
  echo "What's the remote? ..."
  git remote -v
  git push --quiet --set-upstream origin auto-branch
}

setup_git
commit_website_files
upload_files
