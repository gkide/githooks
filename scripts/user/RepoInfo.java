//package com.repo.info;

// Update by scripts/sync-repo-info
public class RepoInfo {
    // build host name, user name, os name version
    static public final String hostName = "host name";
    static public final String hostUser = "user name";
    static public final String hostOsNV = "Ubuntu 14.04";

    // build usr, emai, data time
    static public final String buildUser = "user-name <email@demo.com>";
    static public final String buildTime = "2018-01-30 10:20:30 +0845";

    // source modify date time
    static public final String modifyTime = "2019-01-30 20:50:59 +8123";

    // remote repo url & hash
    static public final String repoHash = "615"; // SVN Reversion or Git Commit Hash
    static public final String repoUrl = "svn://addr/app/trunk/mta"; // remote repo url

    // semantic version
    static public final long major = 11;
    static public final long minor = 22;
    static public final long patch = 33;
    static public final String tweak = "alpha";
    static public final String semver = "11.22.33-alpha";

    public static void main(String[] args) {
        System.out.println(hostName);
        System.out.println(hostUser);
        System.out.println(hostOsNV);

        System.out.println(buildUser);
        System.out.println(buildTime);

        System.out.println(modifyTime);
        System.out.println(repoHash);
        System.out.println(repoUrl);

        System.out.println(major);
        System.out.println(minor);
        System.out.println(patch);
        System.out.println(tweak);
        System.out.println(semver);
    }
}
