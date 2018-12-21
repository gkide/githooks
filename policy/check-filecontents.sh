#!/usr/bin/env bash

THIS_DIR=$(dirname $0)
source "${THIS_DIR}/utils.sh"

function check_filecontents()
{
    echo "changed file: ${1}"
}

case "${1}" in
    --about)
        echo "Checking for changed files contents."
        ;;
    *)
        #for file in $(git diff-index --cached --name-only HEAD); do
        #    check_filecontents "${file}"
        #done
        ;;
esac
