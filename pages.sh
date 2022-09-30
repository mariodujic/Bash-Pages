#!/usr/bin/env bash

directory=~/.pages

flag=$1
add_flag="-a"
edit_flag="-e"
delete_flag="-d"
show_flag="-s"
help_flag="-h"

addPage() {
  page=$1
  page_file="$directory/$page.txt"

  if [ -z "$page" ]; then
    echo "Missing page name argument. Type $help_flag for help."
    exit 1
  else
    createStorageIfMissing "$page_file"
    vim "$page_file"
  fi
}

editPage() {
  page_index=$1
  for entry in "$directory"/*; do
    if [[ "$index" == "$page_index" ]]; then
      vim "$entry"
      exit 1
    fi
    index=$((index + 1))
  done
  echo "Unable to find a page with index $page_index".
}

showPages() {
  directory_path_length=$((${#directory} + 2))
  echo "Pages in your repository:"
  index=1
  for entry in "$directory"/*; do
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
  e="$add_flag"
  s="$show_flag"
  d="$delete_flag"
  echo """
  Usage:
  $e  <page_name>   Create/Edit a specific page.
  $s                Show all pages.
  $d  <page_index>  Delete page.
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

if [ "$flag" == "$add_flag" ]; then
  addPage "${*:2}"
elif [ "$flag" == "$edit_flag" ]; then
  editPage "${*:2}"
elif [ "$flag" == "$delete_flag" ]; then
  deletePage "${*:2}"
elif [ "$flag" == "$show_flag" ]; then
  showPages
elif [ "$flag" == "$help_flag" ]; then
  help
else
  echo "Invalid argument. Type $help_flag for instructions."
fi
