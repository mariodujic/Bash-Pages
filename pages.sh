#!/usr/bin/env bash

directory=~/.pages
page_file="$directory/page.txt"

flag=$1
edit_flag="-e"
help_flag="-h"

editPage() {
  vi page_file
}

createStorageIfMissing() {
  if [ ! -d "$directory" ]; then
    mkdir $directory
  fi
  if [ ! -f "$page_file" ]; then
    touch $page_file
  fi
}

createStorageIfMissing

if [ "$flag" == "$edit_flag" ]; then
  editPage
elif [ "$flag" == "$help_flag" ]; then
  help
else
  echo "Invalid argument. Type $help_flag for instructions."
fi