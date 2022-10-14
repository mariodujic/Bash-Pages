#!/usr/bin/env bash

askUninstall() {
  read -p "Would you like to uninstall Pages [Y/n]" -r answer
  if [[ "$answer" = [Yy] ]]; then
    echo -n "Uninstalling Pages: " \
    rm -f /usr/local/bin/pages >/dev/null 2>&1 || { echo "Failed" ; echo "Error removing file, try running uninstall script as sudo"; exit 1; }
    echo "Success"
    exit 1
  elif [[ "$answer" != [Nn] ]]; then
    echo "Unknown answer, please try again."
    askInstall
  fi
}

askUninstall
