#!/usr/bin/env bash

THIS_DIR="$(cd $(dirname $0); pwd; cd - > /dev/null)"
source "${THIS_DIR}/utils.sh"

function check_spell()
{
    which aspell > /dev/null
    if [ ! $? -eq 0 ] ; then
        return 0
    fi

    set -e

    warnings=$(cat "${1}" | grep -v '^#.*' | aspell list)

    if [ ! -z "${warnings}" ] ; then
        echo >&2 "Possible spelling errors in the commit message:"
        echo >&2 "    $(msgRed ${warnings})";
        return 1
    fi
}

case "${1}" in
    --about)
        echo -n "Spell check the commit message using aspell which is: "
        which aspell > /dev/null
        if [ ! $? -eq 0 ] ; then
            echo "not installed"
        else
            echo "installed"
        fi
        ;;
    *)
        check_spell "$@"
        ;;
esac
