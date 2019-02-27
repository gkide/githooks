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
REPO_VCS="GIT";
REPO_DIR="$(git rev-parse --show-toplevel)";

# Repo info file to sync
VS_VFILE="${REPO_DIR}/RepoInfo.h";

# NOTE
# The following value's special chars will be escaped or replaced
# - space     \s+
# - ()        \(
# - *         \*
# - [         \[
# - ]         \]

# Remote repo URL
VS_REPO_URL="#define REPO_URL";
# The repo hash
# - GIT: it is the 7-chars short SHA
# - SVN: it is the reversion number
VS_REPO_HASH="#define REPO_HASH";

# The repo last modification time
# ISO8601 => "2019-01-19 01:00:52 +0800"
VS_MODIFY_TIME="#define MODIFY_TIME";

# User info
VS_BUILD_USER="#define BUILD_USER";
# The current build time, format is ISO8601
VS_BUILD_TIME="#define BUILD_TIME";

# The build host name
VS_HOST_NAME="#define HOST_NAME";
# The build host user name
VS_HOST_USER="#define HOST_USER";
# The build host system name and version
VS_HOST_OSNV="#define HOST_OSNV";
