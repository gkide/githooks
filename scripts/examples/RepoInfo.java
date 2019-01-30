package com.repo.info

// Update by scripts/sync-repo-info
public class RepoInfo {
    // build host name, user name, os name version
    public final String hostName = "host-name";
    public final String hostUser = "user-name";
    public final String hostOsNV = "Ubuntu 14.04";

    // build usr, emai, data time
    public final String buildUser = "user-name <email@demo.com>";
    public final String buildTime = "2018-01-30 10:20:30 +0845";

    // source modify date time
    public final String modifyTime = "2019-01-30 20:50:59 +8123";

    // remote repo url
    public final String repoHash = "615"; // SVN
    public final String repoUrl = "svn://addr/app/trunk/mta";
    public final String repoHash = "14ab478"; // GIT(HTTP)
    public final String repoUrl = "http://addr/app/trunk/mta";
    public final String repoHash = "14ab478"; // GIT(HTTPS)
    public final String repoUrl = "https://addr/app/trunk/mta";
    public final String repoHash = "14ab478"; // GIT(GIT)
    public final String repoUrl = "git@addr.com:app/mta.git";
}
