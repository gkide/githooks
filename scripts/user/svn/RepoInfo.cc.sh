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

USER_EMAIL="user.email.by.hand@my.com"

# Repo root directory, full path
REPO_VCS="SVN";
REPO_DIR=$(svn info | grep "Working Copy Root Path:" | awk '{ print $5; }');

# Repo info file to sync
VS_VFILE="${REPO_DIR}/RepoInfo.cc";

# NOTE
# The following value's special chars will be auto escaped
# user    =>    auto
# space         \s+
# ()            \(
# *             \*
# [             \[
# ]             \]
# .             .       regular expression meta char for only one char

# Remote repo URL
VS_REPO_URL="const std::string RepoInfo::repoUrl =";
# The repo hash
# - GIT: it is the 7-chars short SHA
# - SVN: it is the reversion number
VS_REPO_HASH="const std::string RepoInfo::repoHash =";

# The repo last modification time
# ISO8601 => "2019-01-19 01:00:52 +0800"
VS_MODIFY_TIME="const std::string RepoInfo::modifyTime =";

# The build user info
VS_BUILD_USER="const std::string RepoInfo::buildUser =";
# The current build time, format is ISO8601
VS_BUILD_TIME="const std::string RepoInfo::buildTime";

# The build host name
VS_HOST_NAME="const std::string RepoInfo::hostName =";
# The build host user name
VS_HOST_USER="const std::string RepoInfo::hostUser =";
# The build host system name and version
VS_HOST_OSNV="const std::string RepoInfo::hostOsNV =";

# Semantic version
# Version should consist of MAJOR/MINOR/PATCH/TWEAK
#   The MAJOR, MINOR, PATCH must consit of numbers of [0-9]
#   TWEAK is pre-release part, consist of [a-z0-9.-]
# Each line must has one, like the following
#   MAJOR   Can not ignore, must be 0 ~ 9
#   MINOR   Can not ignore, must be 0 ~ 9
#   PATCH   Can not ignore, must be 0 ~ 9
#   TWEAK   Can be ignored, consist of [a-z0-9.-]

VS_MAJOR="const long RepoInfo::major =";
VS_MINOR="const long RepoInfo::minor =";
VS_PATCH="const long RepoInfo::patch =";
VS_TWEAK="const std::string RepoInfo::tweak =";
VS_SEMVER="const std::string RepoInfo::semver =";
