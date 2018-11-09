#!/usr/bin/env bash

set -ex

VERSION=$1

contribDir=$(dirname $0)

$contribDir/generate-toc.sh $VERSION
$contribDir/generate-dbm-versions.sh

git checkout --orphan $VERSION
git reset

mv Fake_DBM/* .
find . -maxdepth 1 -not -name '*.lua' -not -name '*.toc' -not -name '.git' -not -name '.' -exec rm -rf {} \;

git remote add origin-ssh git@github.com:chadrien/Fake_DBM.git

git add .
git commit -m"${VERSION}"
git tag "${VERSION}"
git push -u origin-ssh HEAD
git push --tags

# create the GitHub release
curl -u chadrien:$GITHUB_ACCESS_TOKEN -XPOST -d "{ \"tag_name\": \"$VERSION\" }" https://api.github.com/repos/chadrien/Fake_DBM/releases

git checkout master
