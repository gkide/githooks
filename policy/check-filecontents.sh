#!/usr/bin/env bash

GIT_REPO_DIR="$(cd ${PWD} && pwd)"
POLICY_DIR="${GIT_REPO_DIR}/scripts/githooks/policy"
source "${POLICY_DIR}/utils.sh"

DEPS_SRC_CHANGED=false

# ...
# deps changed commit SHA1
# previous commit SHA1      ->  .sha1_marker
# ...

function deps_update_sha1_marker()
{
    return

    local sha1_marker="${GIT_REPO_DIR}/deps/.sha1_marker"
    # get the HEAD SHA1, the next one is current commit, which make deps
    # changed, the changing in 'deps/.sha1_marker' do not the current
    # commit SHA1, it is the previous commit SHA1
    #
    # after all done, 'deps/.sha1_marker' point to the commit just after
    # the commit which make 'deps' changed!
    local cur_sha1="$(git log --pretty=oneline -1 HEAD | cut -d ' ' -f 1)"
    if [ -f ${sha1_marker} ]; then
        local pre_sha1="$(cat ${sha1_marker})"
    else
        local pre_sha1="NONE"
    fi

    echo "[C]SHA1: $(msg_green ${cur_sha1})"
    echo "[P]SHA1: $(msg_red ${pre_sha1})"

    echo "${cur_sha1}" > ${sha1_marker}

    # auto add the updated file
    git add ${sha1_marker}
}

function check_filecontents()
{
    return

    file="${1}"

    if [ ! -f ${file} ]; then
        echo "delete : $(msg_red ${file})"
        return 1
    fi

    local str_1="$(echo "${file}" | grep "^deps/CMakeLists.txt$")"
    local str_2="$(echo "${file}" | grep "^deps/cmake/.*")"
    local str_3="$(echo "${file}" | grep "^deps/patches/.*")"
    local deps_changed="${str_1}${str_2}${str_3}"
    if [ "${deps_changed}" != "" ] ; then
        echo "deps changed: $(msg_red ${file})"
        DEPS_SRC_CHANGED=true
    fi
}

case "${1}" in
    --about)
        echo "Checking for changed files contents."
        ;;
    *)
        for file in $(git diff-index --cached --name-only HEAD); do
            check_filecontents "${file}"
        done
        ;;
esac

# Just for example usage, do nothing
if ${DEPS_SRC_CHANGED}; then
    deps_update_sha1_marker
fi
