#!/usr/bin/env bash

GIT_REPO_DIR="$(git rev-parse --show-toplevel)"

# https://www.npmjs.com/package/@gkide/standard-release
if [[ ${1} == */.git/modules/* ]]; then
  standard-release -x -m "${1}" # submodule commit
  # modulePath="$(dirname ${1})"
  # moduleName="$(basename ${modulePath})"
  # echo "update module ${moduleName}"
else
  standard-release -x -m "${GIT_REPO_DIR}/${1}"
fi

exit $?
