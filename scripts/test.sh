#!/usr/bin/env bash
#
# For testing sync-repo-info & release only

THIS_DIR=${PWD}

# Testing temp repo directory
TMEM_DIR=${THIS_DIR}/temp
# Testing user config directory
USER_DIR=${THIS_DIR}/user

GIT_REPO=${TMEM_DIR}/GitRepo
SVN_REPO=${TMEM_DIR}/SvnRepo

# The sync repo info scripts to testing
SyncRelease=${THIS_DIR}/sync-release
SyncRepoInfo=${THIS_DIR}/sync-repo-info

# Import normal shell function-util
# - IS_DEBUG_MODE=true;
# - IS_VERBOSE_MODE=true;
source ${THIS_DIR}/utils.sh;
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
    mkdir ${GIT_REPO}
    cd ${GIT_REPO}
    git init 2>&1 > /dev/null
    cp ${USER_DIR}/RepoInfo.* ${GIT_REPO}/
    cp ${USER_DIR}/git/RepoInfo.* ${GIT_REPO}/
    git remote add orgin https://github.com/GitRepo.git
    git add .
    git commit -m 'chore: init' > /dev/null
    cd - > /dev/null
}

# Init svn repo for testing
function initSvnRepo()
{
    # The SVN meta-repo
    SvnMeta=${TMEM_DIR}/SvnMeta
    mkdir ${SvnMeta}
    cd ${SvnMeta}

    # Creat svn server repo
    svnadmin create SvnRepo
    # For anonymous commit
    cp -f ${USER_DIR}/svn/svnserve.conf SvnRepo/conf/svnserve.conf

    # Start SVN server service
    svnserve -d -r $PWD

    # To check if SVN service is ok
    # netstat -nltp
    # To checkout SVN repo

    cd ${TMEM_DIR}
    svn checkout svn://localhost/SvnRepo > /dev/null
    cd SvnRepo
    mkdir -p subdir;
    touch subdir/readme.md;
    svn add subdir > /dev/null;
    svn commit -m 'add subdir' > /dev/null;
    svn up > /dev/null;

    # Copy the user source files
    cp ${USER_DIR}/RepoInfo.* ${SVN_REPO}/
    cp ${USER_DIR}/svn/RepoInfo.* ${SVN_REPO}/
}

function syncGitRepoInfo()
{
    cd ${GIT_REPO}

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

    ${SyncRelease} $QUIET;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/.sync-repo-info.sh";

    ${SyncRelease} $QUIET CONFIG=RepoInfo.$TYPE.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/RepoInfo.$TYPE.sh";

    mkdir -p subdir; cd subdir;
    cp -f ../.sync-repo-info.sh sync-repo-info.sh
    ${SyncRelease} $QUIET CONFIG=sync-repo-info.sh;
    if [ "$?" = "0" ]; then isOk=true; else isOk=false; fi
    isTestOk "${isOk}" "Checking GIT repo(R): REPO/subdir/sync-repo-info.sh";
}

function syncSvnRepoInfo()
{
    cd ${SVN_REPO}

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
    syncGitRepoInfo h TESTING=true
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
    mkdir ${TMEM_DIR}

    initGitRepo
    syncForGitRepo

    initSvnRepo
    syncForSvnRepo

    # clean up testing repo
    rm -rf ${TMEM_DIR}

    # Kill the svn service
    SVNPID=$(ps -ef | grep svnserve | head -n 1 | awk '{ print $2; }')
    kill ${SVNPID}
}

main
