#!/usr/bin/env bash

VERSION=$1

contribDir=$(dirname $0)

$contribDir/generate-toc.sh $VERSION
$contribDir/generate-version.sh

git checkout --orphan $VERSION
git reset

rm -rf contrib .gitignore

mv Fake_DBM/* .
rmdir Fake_DBM

git add .
git commit -m"${VERSION}"
git tag "${VERSION}"
git push -u origin HEAD
git push --tags

git checkout master
