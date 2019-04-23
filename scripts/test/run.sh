#!/usr/bin/env bash
#
# For testing 'sync-repo-info' & 'sync-release'

REPO_DIR=$(git rev-parse --show-toplevel)
SCRIPTS_DIR=${REPO_DIR}/scripts
TEST_DIR=${REPO_DIR}/scripts/test

# Testing temp repo directory
T_TEMP_DIR=${TEST_DIR}/temp
# User config directory for testing
T_USER_DIR=${TEST_DIR}/user

T_GIT_REPO=${T_TEMP_DIR}/GitRepo
T_SVN_REPO=${T_TEMP_DIR}/SvnRepo

# The sync repo info scripts to testing
SyncRelease=${SCRIPTS_DIR}/sync-release
SyncRepoInfo=${SCRIPTS_DIR}/sync-repo-info

# Import normal shell function-util
# - IS_DEBUG_MODE=true;
# - IS_VERBOSE_MODE=true;
source ${SCRIPTS_DIR}/utils.sh;
IS_DEBUG_MODE=false;

function testFailure()
{
    printf "$(msgRed Failure) - $*\n";
    return 0; # make sure return true
}

function testSuccess()
{
    printf "$(msgGreen Success) - $*\n";
    return 0; # make sure return true
}

function isTestOk()
{
    isOk=$1
    shift
    if [ "$isOk" = "true" ]; then
        testSuccess "$*"
    else
        testFailure "$*"
    fi
    return 0;
}

# Init git repo for testing
function initGitRepo()
{
    mkdir ${T_GIT_REPO}
    cd ${T_GIT_REPO}
    git init 2>&1 > /dev/null
    cp ${T_USER_DIR}/RepoInfo.* ${T_GIT_REPO}/
    cp ${T_USER_DIR}/git/RepoInfo.* ${T_GIT_REPO}/
    git remote add orgin https://github.com/GitRepo.git
    git add .
    git commit -m 'chore: init' > /dev/null
    cd - > /dev/null
}

# Init svn repo for testing
function initSvnRepo()
{
    # The SVN meta-repo
    SvnMeta=${T_TEMP_DIR}/SvnMeta
    mkdir ${SvnMeta}
    cd ${SvnMeta}

    # Creat svn server repo
    svnadmin create SvnRepo
    # For anonymous commit
    cp -f ${T_USER_DIR}/svn/svnserve.conf SvnRepo/conf/svnserve.conf

    # Start SVN server service
    svnserve -d -r $PWD

    # To check if SVN service is ok
    # netstat -nltp
    # To checkout SVN repo

    cd ${T_TEMP_DIR}
    svn checkout svn://localhost/SvnRepo > /dev/null
    cd SvnRepo
    mkdir -p subdir;
    touch subdir/readme.md;
    svn add subdir > /dev/null;
    svn commit -m 'add subdir' > /dev/null;
    svn up > /dev/null;

    # Copy the user source files
    cp ${T_USER_DIR}/RepoInfo.* ${T_SVN_REPO}/
    cp ${T_USER_DIR}/svn/RepoInfo.* ${T_SVN_REPO}/
}

function syncGitRepoInfo()
{
    cd ${T_GIT_REPO}

    TYPE=$1
    QUIET=$2

    if [ "" = "$QUIET" ]; then
        echo "FILE=RepoInfo.$TYPE"
        echo "USER=RepoInfo.$TYPE.sh"
    fi

    cp -f RepoInfo.$TYPE.sh .sync-repo-info.sh

    ${SyncRepoInfo} $QUIET;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(I): REPO/.sync-repo-info.sh";

    ${SyncRepoInfo} $QUIET CONFIG=RepoInfo.$TYPE.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(I): REPO/RepoInfo.$TYPE.sh";

    mkdir -p subdir; cd subdir;
    cp -f ../.sync-repo-info.sh sync-repo-info.sh
    ${SyncRepoInfo} $QUIET CONFIG=sync-repo-info.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(I): REPO/subdir/sync-repo-info.sh";

    cd - > /dev/null;
    export LANG=en_US.UTF-8;
    cp -f RepoInfo.$TYPE.sh .sync-repo-info.sh;
    QUIET="${QUIET} INTERACTIVE=false";

    ${SyncRelease} $QUIET; # auto semver: v0.0.1
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/.sync-repo-info.sh";

    semver_tag="v0.0.1-dev";
    git checkout .
    git tag ${semver_tag}; # auto semver: v0.0.1-dev.0
    ${SyncRelease} $QUIET CONFIG=RepoInfo.$TYPE.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/RepoInfo.$TYPE.sh";

    git tag -d ${semver_tag}
    semver_tag="v0.0.2-pre.110";
    git checkout .
    git tag ${semver_tag}; # auto semver: v0.0.2-pre.111
    ${SyncRelease} $QUIET CONFIG=RepoInfo.$TYPE.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/RepoInfo.$TYPE.sh";

    git tag -d ${semver_tag}
    semver_tag="v0.0.3-rc.20190421";
    git checkout .
    git tag ${semver_tag}; # auto semver: v0.0.3-rc.XXXXXXXX
    ${SyncRelease} $QUIET CONFIG=RepoInfo.$TYPE.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/RepoInfo.$TYPE.sh";

    git tag -d ${semver_tag}
    semver_tag="v0.0.4-rc.20190422+abcdef1234";
    git checkout .
    git tag ${semver_tag}; # auto semver: v0.0.4-rc.XXXXXXXX
    ${SyncRelease} $QUIET CONFIG=RepoInfo.$TYPE.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/RepoInfo.$TYPE.sh";

    git checkout .
    git tag -d ${semver_tag}
    semver_tag="v0.0.5-rc.20190423+abcdef1234";
    git tag ${semver_tag}; # auto semver: v0.0.5-rc.XXXXXXXX
    mkdir -p subdir; cd subdir;
    cp -f ../.sync-repo-info.sh sync-repo-info.sh
    ${SyncRelease} $QUIET CONFIG=sync-repo-info.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/subdir/sync-repo-info.sh";

    git tag -d ${semver_tag}
}

function syncSvnRepoInfo()
{
    cd ${T_SVN_REPO}

    TYPE=$1
    QUIET=$2

    if [ "" = "$QUIET" ]; then
        echo "FILE=RepoInfo.$TYPE"
        echo "USER=RepoInfo.$TYPE.sh"
    fi

    cp -f RepoInfo.$TYPE.sh .sync-repo-info.sh

    ${SyncRepoInfo} $QUIET;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking SVN repo(I): REPO/.sync-repo-info.sh";

    ${SyncRepoInfo} $QUIET CONFIG=RepoInfo.$TYPE.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking SVN repo(I): REPO/RepoInfo.$TYPE.sh";

    cd subdir;
    cp -f ../.sync-repo-info.sh sync-repo-info.sh;
    ${SyncRepoInfo} $QUIET CONFIG=sync-repo-info.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking SVN repo(I): REPO/subdir/sync-repo-info.sh";
}

function syncForGitRepo()
{
    echo '----------------------------------------'
    syncGitRepoInfo h TESTING=true;
    echo '----------------------------------------'
    syncGitRepoInfo c1 TESTING=true
    echo '----------------------------------------'
    syncGitRepoInfo c2 TESTING=true
    echo '----------------------------------------'
    syncGitRepoInfo cc TESTING=true
    echo '----------------------------------------'
    syncGitRepoInfo cpp TESTING=true
    echo '----------------------------------------'
    syncGitRepoInfo java TESTING=true
    echo '----------------------------------------'
    syncGitRepoInfo cmake TESTING=true
}

function syncForSvnRepo()
{
    echo '----------------------------------------'
    syncSvnRepoInfo h TESTING=true
    echo '----------------------------------------'
    syncSvnRepoInfo c1 TESTING=true
    echo '----------------------------------------'
    syncSvnRepoInfo c2 TESTING=true
    echo '----------------------------------------'
    syncSvnRepoInfo cc TESTING=true
    echo '----------------------------------------'
    syncSvnRepoInfo cpp TESTING=true
    echo '----------------------------------------'
    syncSvnRepoInfo java TESTING=true
    echo '----------------------------------------'
    syncSvnRepoInfo cmake TESTING=true
}

function main()
{
    # Init testing repo
    mkdir ${T_TEMP_DIR}

    initGitRepo
    syncForGitRepo

    #initSvnRepo
    #syncForSvnRepo

    # clean up testing repo
    rm -rf ${T_TEMP_DIR}

    # Kill the svn service
    #SVNPID=$(ps -ef | grep svnserve | head -n 1 | awk '{ print $2; }')
    #kill ${SVNPID}
}

main
