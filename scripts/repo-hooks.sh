#!/usr/bin/env bash

#################################################
# This is the repo-hooks project release script #
#################################################

# Exit the script if any statement returns a non-true return value
set -e
# Show error if used undefined variable
set -u
# Pipe fail if any one of the pipe command failed
set -o pipefail

_sed=$([ "$(uname)" = "Darwin" ] && echo "sed -E" || echo "sed -r");

# Current directory of full path with symbolic link resolved
THIS_DIR="$(realpath ${0%/*})";

# Import normal shell function-util
source ${THIS_DIR}/utils.sh;

REPO_DIR=$(git rev-parse --show-toplevel);
AUTO_TAG=$(standard-release -x -c -r 2>/dev/null \
    | head -n 1 | awk -F':' 'gsub(/[ ]/,"",$2) { print $2; }');

infoMsg "----------------------------------------";
infoMsgL "Release semver [$(valMsg ${AUTO_TAG})]: ";
SEMVER_TAG="${AUTO_TAG}"; # Just Enter use the auto one
read -p "" usrInput;
[ -n "${usrInput}" ] && SEMVER_TAG="${usrInput}";

if ! $(standard-release -x --is-semver "${SEMVER_TAG}"); then
    errMsg "Invalid release semver($(valMsg ${SEMVER_TAG}))";
fi

SYNC_SEMVER=${REPO_DIR}/scripts/sync-release;
${_sed} -i.bk "s/^(REPO_HOOKS_VERSION=\")([0-9a-z\.-]+)(\";)$/\1${SEMVER_TAG}\3/" ${SYNC_SEMVER};
rm ${SYNC_SEMVER}.bk;

SYNC_REPO_INFO=${REPO_DIR}/scripts/sync-repo-info;
${_sed} -i.bk "s/^(REPO_HOOKS_VERSION=\")([0-9a-z\.-]+)(\";)$/\1${SEMVER_TAG}\3/" ${SYNC_REPO_INFO};
rm ${SYNC_REPO_INFO}.bk;

# Commit & Tag message
TAG_HDR="chore(auto): tag ${SEMVER_TAG}";
CMT_HDR="chore(auto): release ${SEMVER_TAG}";
MSG_BDY="

Detail changes see CHANGELOG.md";

TAG_MSG="${TAG_HDR}${MSG_BDY}";
COMMIT_MSG="${CMT_HDR}${MSG_BDY}";

infoMsg "----------------------------------------";
infoMsg "The message for signed-off commit";
printf "$(msgGreen "${COMMIT_MSG}")\n";

infoMsg "----------------------------------------";
infoMsg "The message for signed annotated tag";
printf "$(msgGreen "${TAG_MSG}")\n";

# Git commit & tag
infoMsg "----------------------------------------";
infoMsgL "Show diff $(valMsg CHANGELOG.md) & $(valMsg SemVer) (y/n) [n]: ";
read -p "" usrInput;
if isYes "${usrInput}"; then
    git diff ${SYNC_SEMVER};
    git diff ${SYNC_REPO_INFO};
    git diff ${REPO_DIR}/CHANGELOG.md;
fi

infoMsg "----------------------------------------";
infoMsgL "Confirm $(valMsg GIT) commit & tag (y/n) [n]: ";
read -p "" usrInput;
if isNo "${usrInput}"; then
    errMsg "Release stop, confirm with $(keyMsg y) or $(keyMsg Y)";
fi

if isYes "${usrInput}"; then
    git add ${SYNC_SEMVER};
    git add ${SYNC_REPO_INFO};
    git add ${REPO_DIR}/CHANGELOG.md;

    # Do release commit
    git commit --signoff -m "${COMMIT_MSG}";
    # Do release tag
    git tag --sign -a "${SEMVER_TAG}" -m "${TAG_MSG}";
fi
