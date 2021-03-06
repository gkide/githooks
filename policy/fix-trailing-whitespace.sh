#!/usr/bin/env bash
#
# https://github.com/imoldman/config/blob/master/pre-commit.git.sh
#
# A git hook script to find and fix trailing whitespace in your commits.

THIS_DIR="$(cd $(dirname $0); pwd; cd - > /dev/null)"
source "${THIS_DIR}/utils.sh"

# change IFS to ignore filename's space in |for|
IFS="
"

# autoremove trailing whitespace
for line in $(git diff --check --cached | sed '/^[+-]/d'); do
  # get file name
  file_name=""
  if $(hostIsMacos); then
    file_name="$(echo ${line} | sed -E 's/:[0-9]+: .*//')"
  else
    file_name="$(echo ${line} | sed -r 's/:[0-9]+: .*//')"
  fi

  # display tips
  # echo "remove trailing whitespace: $(msgGreen ${file_name})"

  # since ${file_name} in working directory isn't always
  # equal to ${file_name} in index, so backup it
  backup_file="${file_name}.backup"
  mv -f "${file_name}" "${backup_file}"

  # discard changes in working directory
  git checkout -- "${file_name}"

  # remove trailing whitespace
  if $(hostIsWindows); then
    # in windows, `sed -i` adds ready-only attribute to
    # ${file_name}, so we use temp file instead
    sed 's/[[:space:]]*$//' "${file_name}" > "${file_name}.temp"
    mv -f "${file_name}.temp" "${file_name}"
  elif $(hostIsMacos); then
    sed -i "" 's/[[:space:]]*$//' "${file_name}"
  elif $(hostIsLinux); then
    sed -i 's/[[:space:]]*$//' "${file_name}"
  else
    $(msgRed "PLANTFORM UNKNOWN, ABORT COMMIT.")
    echo "Backup to: $(msgRed ${backup_file})"
    exit 1
  fi

  git add "${file_name}"

  # restore the ${file_name}
  sed 's/[[:space:]]*$//' "${backup_file}" > "${file_name}"
  rm "${backup_file}"
done

# TODO, fix $ git commit --amend, but actually make modification
#if [ "x`git status -s | grep '^[A|D|M]'`" = "x" ]; then
#  # empty commit
#  $(msgRed "NOTHING CHANGES, ABORT COMMIT!")
#  exit 1
#fi

# Now, everything is ok, do commit
exit
