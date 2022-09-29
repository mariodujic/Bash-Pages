#!/usr/bin/env bash

directory=~/.pages

flag=$1
edit_flag="-e"
delete_flag="-d"
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
    if [[ "$entry" == "$directory"/* ]]; then
      echo "--"
      exit 1
    fi
    echo -n "$index. "
    echo "$entry" | tail -c +"$directory_path_length"
    index=$((index + 1))
  done
}

deletePage() {
  page_index=$1
  index=1
  page_path=""

  for entry in "$directory"/*; do
    if [[ "$index" == "$page_index" ]]; then
      page_path="$entry"
    fi
    index=$((index + 1))
  done

  if [ -z "$page_index" ]; then
    echo "Missing page index. Type $help_flag for help."
    exit 1
  else
    read -p "Would you like to delete $page_index. page? [Y/n]" -r answer
    if [[ "$answer" = [Yy] ]]; then
      echo "$page_index. page deleted."
      rm "$page_path"
      exit 1
    elif [[ "$answer" != [Nn] ]]; then
      echo "Unknown answer, please try again."
      deletePage "$page_index"
    fi
  fi
}

help() {
  echo """
  Usage:
      -e <page_name>    Create/Edit a specific page.
      -s                Show all pages.
      -d <page_index>   Delete page.
  """
}

createStorageIfMissing() {
  page=$1
  if [ ! -d "$directory" ]; then
    mkdir $directory
  fi
  if [ ! -f "$page" ]; then
    touch "$page"
  fi
}

createStorageIfMissing

if [ "$flag" == "$edit_flag" ]; then
  editPage "${*:2}"
elif [ "$flag" == "$delete_flag" ]; then
  deletePage "${*:2}"
elif [ "$flag" == "$show_pages_flag" ]; then
  showPages
elif [ "$flag" == "$help_flag" ]; then
  help
else
  echo "Invalid argument. Type $help_flag for instructions."
fi
