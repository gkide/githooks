#include <string>
#include <iostream>

// Update by scripts/sync-repo-info
struct RepoInfo {
    // build host name, user name, os name version
    static const string hostName = "host-name";
    static const string hostUser = "user-name";
    static const string hostOsNV = "Ubuntu 14.04";

    // build usr, emai, data time
    static const string buildUser = "user-name <email@demo.com>";
    static const string buildTime = "2018-01-30 10:20:30 +0845";

    // source modify date time
    static const string modifyTime = "2019-01-30 20:50:59 +8123";

    // remote repo url
    static const string repoHash = "615"; // SVN
    static const string repoUrl = "svn://addr/app/trunk/mta";
    static const string repoHash = "14ab478"; // GIT(HTTP)
    static const string repoUrl = "http://addr/app/trunk/mta";
    static const string repoHash = "14ab478"; // GIT(HTTPS)
    static const string repoUrl = "https://addr/app/trunk/mta";
    static const string repoHash = "14ab478"; // GIT(GIT)
    static const string repoUrl = "git@addr.com:app/mta.git";
};
