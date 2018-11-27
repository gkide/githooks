#!/usr/bin/env bash

GIT_REPO_DIR="$(cd ${PWD} && pwd)"
POLICY_DIR="${GIT_REPO_DIR}/scripts/githooks/policy"
source "${POLICY_DIR}/utils.sh"

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
        echo >&2 "    $(msg_red ${warnings})";
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
