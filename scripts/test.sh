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

function initGitRepo()
{
    mkdir ${GIT_REPO}
    cd ${GIT_REPO}
    git init 2>&1 > /dev/null
    cp ${USER_DIR}/RepoInfo.* ${GIT_REPO}/
    git remote add orgin https://github.com/GitRepo.git
    git add .
    git commit -m 'chore: init' > /dev/null
    cd - > /dev/null
    echo "Init git repo for testing."
}

function initSvnRepo()
{
    # The SVN meta-repo
    SvnMeta=${TMEM_DIR}/SvnMeta
    mkdir ${SvnMeta}
    cd ${SvnMeta}
    # Creat svn server repo
    svnadmin create SvnRepo
    # Start SVN server service
    svnserve -d -r $PWD
    cd ${TMEM_DIR}
    # To check if SVN service is ok
    # netstat -nltp
    # To checkout SVN repo
    svn checkout svn://localhost/SvnRepo
    # Copy the user source files
    cp ${USER_DIR}/RepoInfo.* ${GIT_REPO}/
    echo "Init svn repo for testing."
}

function syncForjava()
{
    cd ${GIT_REPO}

    # Given GIT & config file
    ${SyncRepoInfo} SVN;
    if [ "$?" != "0" ]; then isOk=true; else isOk=true; fi
    isTestOk "${isOk}" "Checking given GIT for svn repo"

echo "STOP";exit 1;
    # Auto detected SVN or GIT
    # Use default config file: .sync-repo-info
    cp RepoInfo.java.sh .sync-repo-info
    ${SyncRepoInfo}
    [ "$?" != "0" ] && echo "ERROR: RepoInfo.java.sh/.sync-repo-info"; exit 1;



    git diff
    #echo "ERROR sync repo info for java"
    cd - > /dev/null
}

function main()
{
    # Init testing repo
    mkdir ${TMEM_DIR}
    initGitRepo
    #initSvnRepo

    syncForjava

    # clean up testing repo
    #rm -rf ${TMEM_DIR}
    # Kill the svn service
    #SVNPID=$(ps -ef | grep svnserve | head -n 1 | awk '{ print $2; }')
    #kill ${SVNPID}
}

main
