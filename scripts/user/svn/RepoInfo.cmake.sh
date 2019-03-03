#!/usr/bin/env bash

# NOTE:
#
# 1. User Name & Email Must be consist of [0-9A-Za-z@.- ]
#    The format is: USER_NAME <USER_EMAIL>
#    - GIT: USER_NAME/USER_EMAIL the same as 'git config' if not set
#    - SVN: USER_NAME auto get from 'svn log', USER_EMAIL is empty by default
#    if not set, then user name & email will auto detected as above
#    USER_NAME="my name"
#    USER_EMAIL="email@my.com"
# 2. This current file & ${VS_VFILE} should be files of the git repo

# Repo root directory, full path
REPO_VCS="SVN";
REPO_DIR=$(svn info | grep "Working Copy Root Path:" | awk '{ print $5; }');

# Repo info file to sync
VS_VFILE="${REPO_DIR}/RepoInfo.cmake1";

# NOTE
# The following value's special chars will be escaped or replaced
# - space     \s+
# - ()        \(
# - *         \*
# - [         \[
# - ]         \]

# Remote repo URL
VS_REPO_URL="set(MY_REPO_URL"
# The repo hash
# - GIT: it is the 7-chars short SHA
# - SVN: it is the reversion number
VS_REPO_HASH="MY_REPO_HASH"

# The repo last modification time
# ISO8601 => "2019-01-19 01:00:52 +0800"
VS_MODIFY_TIME="set(MY_MODIFY_TIME"

# The build user info
VS_BUILD_USER="set(MY_BUILD_USER"
# The current build time, format is ISO8601
VS_BUILD_TIME="set(MY_BUILD_TIME"

# The build host name
VS_HOST_NAME="set(MY_HOST_NAME"
# The build host user name
VS_HOST_USER="set(MY_HOST_USER"
# The build host system name and version
VS_HOST_OSNV="set(MY_HOST_OSNV"

# Semantic version
# Version should consist of MAJOR/MINOR/PATCH/TWEAK
#   The MAJOR, MINOR, PATCH must consit of numbers of [0-9]
#   TWEAK is pre-release part, consist of [a-z0-9.-]
# Each line must has one, like the following
#   MAJOR   Can not ignore, must be 0 ~ 9
#   MINOR   Can not ignore, must be 0 ~ 9
#   PATCH   Can not ignore, must be 0 ~ 9
#   TWEAK   Can be ignored, consist of [a-z0-9.-]

VS_MAJOR="set(MY_SEMVER_MAJOR"
VS_MINOR="set(MY_SEMVER_MINOR"
VS_PATCH="set(MY_SEMVER_PATCH"
VS_TWEAK="set(MY_SEMVER_TWEAK"
