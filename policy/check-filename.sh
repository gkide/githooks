#!/usr/bin/env bash
#
# check if we have non-ASCII filenames, if it does then no commit

THIS_DIR="$(cd $(dirname $0); pwd; cd - > /dev/null)"
source "${THIS_DIR}/utils.sh"

# If you want to allow non-ASCII filenames set this variable to true.
allownonascii=$(git config --bool hooks.allownonascii)

# Redirect output to stderr.
exec 1>&2

# Cross platform projects tend to avoid non-ASCII filenames; prevent
# them from being added to the repository. We exploit the fact that the
# printable range starts at the space character and ends with tilde.
if [ "$allownonascii" != "true" ] &&
    # Note that the use of brackets around a tr range is ok here, (it's
    # even required, for portability to Solaris 10's /usr/bin/tr), since
    # the square bracket bytes happen to fall in the designated range.
    test $(git diff --cached --name-only --diff-filter=A -z HEAD |
           LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
then
    echo "$(msgRed Error): Attempt to add a non-ASCII file name."
    echo
    echo "This can cause problems if you want to work with people on other platforms."
    echo "To be portable it is advisable to rename the file."
    echo
    echo "If you know what you are doing you can disable this check using:"
    echo "$ $(msgRed 'git config hooks.allownonascii true')"
    exit 1
fi
