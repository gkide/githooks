#!/usr/bin/env bash

THIS_DIR="$(cd $(dirname $0); pwd; cd - > /dev/null)"
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
