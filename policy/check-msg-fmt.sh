#!/usr/bin/env bash

GIT_REPO_DIR="$(git rev-parse --show-toplevel)"

# https://www.npmjs.com/package/@gkide/standard-release
standard-release -x -m "${GIT_REPO_DIR}/${1}"

exit $?
