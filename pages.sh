#!/usr/bin/env bash

directory=~/.pages

flag=$1
edit_flag="-e"
show_pages_flag="-s"
help_flag="-h"

editPage() {
  page=$1
  page_file="$directory/$page.txt"

  if [ -z "$page" ]; then
    echo "Missing page name argument. Type $help_flag for help."
    exit 1
  else
    createStorageIfMissing "$page_file"
    vi "$page_file"
  fi
}

showPages() {
  directory_path_length=$((${#directory} + 2))
  echo "Pages in your repository are:"
  index=1
  for entry in "$directory"/*; do
    echo -n "$index. "
    echo "$entry" | tail -c +"$directory_path_length"
    index=$((index + 1))
  done
}

help() {
  echo """
  Usage:
      -e <page_name>     Create/Edit a specific page.
  """
}

createStorageIfMissing() {
  page=$1
  if [ ! -d "$directory" ]; then
    mkdir $directory
  fi
  if [ ! -f "$page" ]; then
    touch $page
  fi
}

createStorageIfMissing

if [ "$flag" == "$edit_flag" ]; then
  editPage "${*:2}"
elif [ "$flag" == "$show_pages_flag" ]; then
  showPages
elif [ "$flag" == "$help_flag" ]; then
  help
else
  echo "Invalid argument. Type $help_flag for instructions."
fi
