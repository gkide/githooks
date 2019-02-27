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
VS_VFILE="${REPO_DIR}/RepoInfo.cpp";

# NOTE
# The following value's special chars will be escaped or replaced
# - space     \s+
# - ()        \(
# - *         \*
# - [         \[
# - ]         \]

# Remote repo URL
VS_REPO_URL="const std::string RepoInfo::repoUrl =";
# The repo hash
# - GIT: it is the 7-chars short SHA
# - SVN: it is the reversion number
VS_REPO_HASH="const std::string RepoInfo::repoHash =";

# The repo last modification time
# ISO8601 => "2019-01-19 01:00:52 +0800"
VS_MODIFY_TIME="const std::string RepoInfo::modifyTime =";

# User info
VS_BUILD_USER="const std::string RepoInfo::buildUser =";
# The current build time, format is ISO8601
VS_BUILD_TIME="const std::string RepoInfo::buildTime";

# The build host name
VS_HOST_NAME="const std::string RepoInfo::hostName =";
# The build host user name
VS_HOST_USER="const std::string RepoInfo::hostUser =";
# The build host system name and version
VS_HOST_OSNV="const std::string RepoInfo::hostOsNV =";
