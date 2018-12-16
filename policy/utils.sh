#!/usr/bin/env bash

function detect_platform()
{
    local platform="windows"

    local uname_result=`uname`
    if [ "${uname_result}" = "Linux" ]; then
        platform="linux"
    elif [ "${uname_result}" = "Darwin" ]; then
        platform="macos"
    fi

    echo "${platform}"
}

function is_windows()
{
    test $(detect_platform) = "windows"
}

function is_linux()
{
    test $(detect_platform) = "linux"
}

function is_macos()
{
    test $(detect_platform) = "macos"
}

# Example Usage
function usage_example_1()
{
    if is_windows; then
        echo "windows"
    elif is_linux; then
        echo "linux"
    elif is_macos; then
        echo "macos"
    else
        echo "xxx"
    fi
}

# man console_codes

function msg_red()
{
    echo -e "\033[31m${1}\033[0m"
}

function msg_green()
{
    echo -e "\033[32m${1}\033[0m"
}

function msg_brown()
{
    echo -e "\033[33m${1}\033[0m"
}

function msg_blue()
{
    echo -e "\033[34m${1}\033[0m"
}

function msg_magenta()
{
    echo -e "\033[35m${1}\033[0m"
}

function msg_cyan()
{
    echo -e "\033[36m${1}\033[0m"
}

function msg_white()
{
    echo -e "\033[37m${1}\033[0m"
}

# Example Usage
function usage_example_2()
{
    msg_red     "msg-red"
    msg_green   "msg-green"
    msg_brown   "msg-brown"
    msg_blue    "msg-blue"
    msg_magenta "msg-magenta"
    msg_cyan    "msg-cyan"
    msg_white   "msg-white"

    local msg="\n"
    msg="${msg}msg: $(msg_red red)\n"
    msg="${msg}msg: $(msg_green green)\n"
    msg="${msg}msg: $(msg_brown brown)\n"
    msg="${msg}msg: $(msg_blue blue)\n"
    msg="${msg}msg: $(msg_magenta magenta)\n"
    msg="${msg}msg: $(msg_cyan cyan)\n"
    msg="${msg}msg: $(msg_white white)\n"
    printf "${msg}"
}
