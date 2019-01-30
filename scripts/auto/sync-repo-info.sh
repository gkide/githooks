#!/usr/bin/env bash

# Must be consist of [0-9A-Za-z.- ]
# The format is: USER_NAME <USER_EMAIL>
# - GIT: USER_NAME/USER_EMAIL the same as 'git config' if not set
# - SVN: USER_NAME auto get from 'svn log', USER_EMAIL is empty by default
#USER_NAME="my name"
#USER_EMAIL="email@my.com"

# Repo root directory, full path
REPO_DIR="$(git rev-parse --show-toplevel)";

# RepoInfo.java
################################################################################
if false; then
# Repo info file to auto sync
VS_VFILE="${REPO_DIR}/scripts/examples/RepoInfo.java";

# NOTE
# The following value's special chars will be escaped or replaced
# - space     \s+
# - ()        \(
# - *         \*
# - [         \[
# - ]         \]

# Remote repo URL
VS_REPO_URL=" static public final String repoUrl =";
# The repo hash
# - GIT: it is the 7-chars short SHA
# - SVN: it is the reversion number
VS_REPO_HASH=" static public final String repoHash =";

# The repo last modification time
# ISO8601 => "2019-01-19 01:00:52 +0800"
VS_MODIFY_TIME=" static public final String modifyTime =";

# User info
VS_BUILD_USER=" static public final String buildUser =";
# The current build time, format is ISO8601
VS_BUILD_TIME=" static public final String buildTime =";

# The build host name
VS_HOST_NAME=" static public final String hostName =";
# The build host user name
VS_HOST_USER=" static public final String hostUser =";
# The build host system name and version
VS_HOST_OSNV=" static public final String hostOsNV =";
fi

# RepoInfo.cc
################################################################################
if false; then
VS_VFILE="${REPO_DIR}/scripts/examples/RepoInfo.cc";
VS_REPO_URL="const std::string RepoInfo::repoUrl =";
VS_REPO_HASH="const std::string RepoInfo::repoHash =";
VS_MODIFY_TIME="const std::string RepoInfo::modifyTime =";
VS_BUILD_USER="const std::string RepoInfo::buildUser =";
VS_BUILD_TIME="const std::string RepoInfo::buildTime =";
VS_HOST_NAME="const std::string RepoInfo::hostName =";
VS_HOST_USER="const std::string RepoInfo::hostUser =";
VS_HOST_OSNV="const std::string RepoInfo::hostOsNV =";
fi

# RepoInfo.c
################################################################################
if false; then
if false; then
VS_VFILE="${REPO_DIR}/scripts/examples/RepoInfo.c";
VS_REPO_URL="static const char repo_url[] =";
VS_REPO_HASH="static const char repo_hash[] =";
VS_MODIFY_TIME="static const char modify_time[] =";
VS_BUILD_USER="static const char build_user[] =";
VS_BUILD_TIME="static const char build_time[] =";
VS_HOST_NAME="static const char host_name[] =";
VS_HOST_USER="static const char host_user[] =";
VS_HOST_OSNV="static const char host_osnv[] =";
else
VS_VFILE="${REPO_DIR}/scripts/examples/RepoInfo.c";
VS_REPO_URL="static const char *repo_url =";
VS_REPO_HASH="static const char *repo_hash =";
VS_MODIFY_TIME="static const char *modify_time =";
VS_BUILD_USER="static const char *build_user =";
VS_BUILD_TIME="static const char *build_time =";
VS_HOST_NAME="static const char *host_name =";
VS_HOST_USER="static const char *host_user =";
VS_HOST_OSNV="static const char *host_osnv =";
fi
fi

# RepoInfo.h
################################################################################
if true; then
VS_VFILE="${REPO_DIR}/scripts/examples/RepoInfo.h";
VS_REPO_URL="#define REPO_URL";
VS_REPO_HASH="#define REPO_HASH";
VS_MODIFY_TIME="#define MODIFY_TIME";
VS_BUILD_USER="#define BUILD_USER";
VS_BUILD_TIME="#define BUILD_TIME";
VS_HOST_NAME="#define HOST_NAME";
VS_HOST_USER="#define HOST_USER";
VS_HOST_OSNV="#define HOST_OSNV";
fi
