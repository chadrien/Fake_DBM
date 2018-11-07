#!/usr/bin/env bash
# requires jq

set -ex

contribDir=$(dirname $(dirname $0))

latestFakeDbmVersion=$(git log --tags --no-walk --pretty="%D" | grep -o "[0-9][0-9.]*" | head -1)

latestDbmVersionsKnown=$(curl -s https://api.github.com/repos/chadrien/Fake_DBM/contents/dbm_versions.lua?ref=${latestFakeDbmVersion} | jq -r .content)
$contribDir/generate-dbm-versions.sh
# the content we get from github is base64 encoded, so let's base64 encode the generated file,
# as it will be simpler to compare 2 simple strings than 2 multiline strings
currentDbmVersions=$(cat $(dirname $contribDir)/Fake_DBM/dbm_versions.lua | base64)

if [ "${currentDbmVersions}" = "${latestDbmVersionsKnown}" ]; then
    echo "Version didn't change, nothing to do"
else
    nextMinorVersion=$(($(echo $latestFakeDbmVersion | grep -o "[0-9]*$")+1))
    $contribDir/release.sh 1.0.${nextMinorVersion}
fi
