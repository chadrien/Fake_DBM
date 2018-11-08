#!/usr/bin/env bash

set -ex

VERSION=$1

TEMPLATE=$(cat <<EOM
## Interface: 80000
## Title: Fake DBM
## Notes: Makes DBM think you have DBM installed
## Author: chadrien
## Version: ${VERSION}

dbm_versions.lua
main.lua
EOM
)

echo "$TEMPLATE" > $(dirname $(dirname $0))/Fake_DBM/Fake_DBM.toc
