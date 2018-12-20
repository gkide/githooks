#!/usr/bin/env bash

# Performs steps to tag a release.
# step No.1: parse project version
# step No.2: valid project version
# step No.3: update changelog
# step No.4: do git commit
# step No.5: do git tag

# Exit the script if any statement returns a non-true return value
#set -e
# Show error if used undefined variable
#set -u
# Pipe fail if any one of the pipe command failed
#set -o pipefail

# The directory which contains current script file
__THIS_DIR=$(cd $(dirname $0); pwd)

# Change working directory to project root
__PROJECT_DIR="$(git rev-parse --show-toplevel)"
cd "${__PROJECT_DIR}"

source ${__PROJECT_DIR}/.release

__sed=$( [ "$(uname)" = Darwin ] && echo 'sed -E' || echo 'sed -re' )

# Get the latest annotated tag
__LAST_TAG=$(git describe --abbrev=0)
[ -z "${__LAST_TAG}" ] && { echo 'ERROR: no tag found'; exit 1; }

__VERSION_MAJOR=$(grep "${PVS_PREFIX_MAJOR}" ${PVS_FILE} \
    | ${__sed} "s/^${PVS_PREFIX_MAJOR}\s*([0-9]+)\s*${PVS_SUFFIX_MAJOR}/\1/")

__VERSION_MINOR=$(grep "${PVS_PREFIX_MINOR}" ${PVS_FILE} \
    | ${__sed} "s/^${PVS_PREFIX_MINOR}\s*([0-9]+)\s*${PVS_SUFFIX_MINOR}/\1/")

__VERSION_PATCH=$(grep "${PVS_PREFIX_PATCH}" ${PVS_FILE} \
    | ${__sed} "s/^${PVS_PREFIX_PATCH}\s*([0-9]+)\s*${PVS_SUFFIX_PATCH}/\1/")

__VERSION_TWEAK=$(grep "${PVS_PREFIX_TWEAK}" ${PVS_FILE} \
    | ${__sed} "s/^${PVS_PREFIX_TWEAK}\s*(([\da-z-]+(\.[\da-z-]+)*)?(\+[\da-z-]+(\.[\da-z-]+)*)?)\s*${PVS_SUFFIX_TWEAK}/\1/")

__VERSION_TWEAK=$(echo ${__VERSION_TWEAK} | sed "s/\'//g")
__VERSION_TWEAK=$(echo ${__VERSION_TWEAK} | sed "s/\"//g")

if [ -z "${__VERSION_TWEAK}" ]; then
    __VERSION="${__VERSION_MAJOR}.${__VERSION_MINOR}.${__VERSION_PATCH}"
else
    __VERSION="${__VERSION_MAJOR}.${__VERSION_MINOR}.${__VERSION_PATCH}-${__VERSION_TWEAK}"
fi

{ [ -z "$__VERSION_MAJOR" ] || [ -z "$__VERSION_MINOR" ] || [ -z "$__VERSION_PATCH" ]; } \
    && { echo "ERROR: version parse failed: ${__VERSION}"; exit 1; }

# Check if __VERSION is valid semver
standard-release -x --is-semver "${__VERSION}"
if [ "$?" != "0" ]; then
    echo "ERROR: invalid semver: ${__VERSION}"; exit 1;
fi

__NEXT_TAG="v${__VERSION}"
__API_LEVEL=${__VERSION_MAJOR}

if [ -z "${PRC_RELEASE_MSG}" ]; then
    __RELEASE_MSG="chore(release): ${__NEXT_TAG}"
else
    __RELEASE_MSG="chore(release): ${PRC_RELEASE_MSG} ${__NEXT_TAG}"
fi

echo "Latest tag : ${__LAST_TAG}"
echo "Release tag: ${__NEXT_TAG}"

__CHANGELOG='CHANGELOG.md'
if [ -n "${PUC_CHANGELOG}" ]; then
    __CHANGELOG="${PUC_CHANGELOG}"
fi

# Update CHANGELOG.md from __LAST_TAG to HEAD
standard-release -x -c "${PUC_CHANGELOG}" > /dev/null
if [ "$?" != "0" ]; then
    echo "ERROR: update changelog: ${__CHANGELOG}"; exit 1;
fi

git add "${__CHANGELOG}"
git commit -m "${__RELEASE_MSG} 

More detail changes see: ${__CHANGELOG}"

git tag --sign -a v"${__VERSION}" -m "${__RELEASE_MSG}"