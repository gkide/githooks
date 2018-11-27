#!/usr/bin/env bash

msg=$(cat "${1}")

# https://github.com/conventional-changelog/validate-commit-msg
# node.js project, to validate commit message
validate-commit-msg ${msg}

exit $?
