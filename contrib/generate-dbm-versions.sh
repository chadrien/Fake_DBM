#!/usr/bin/env bash

set -ex

latestVersionUrl='https://wow.curseforge.com/projects/deadly-boss-mods/files/latest'
tmpDir=$(dirname $0)/tmp
versionSourceFile=DBM-Core/DBM-Core.lua

mkdir $tmpDir
curl -sL $latestVersionUrl > $tmpDir/dbm.zip
unzip $tmpDir/dbm.zip $versionSourceFile -d $tmpDir

REVISION=$(cat $tmpDir/$versionSourceFile | grep 'ReleaseRevision =' | grep -o "[0-9][0-9]*")
VERSION=$(cat $tmpDir/$versionSourceFile | grep 'DisplayVersion =' | grep -o "\".*\"" | sed s/\"//g)

TEMPLATE=$(cat <<EOM
dbmRevision = "${REVISION}"
dbmVersion = "${VERSION}"
EOM
)

echo "$TEMPLATE" > $(dirname $(dirname $0))/Fake_DBM/dbm_versions.lua

rm -rf $tmpDir
