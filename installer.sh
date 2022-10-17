#!/usr/bin/env bash

askInstall() {
  read -p "Would you like to install Pages [Y/n]" -r answer
  if [[ "$answer" = [Yy] ]]; then
    echo "Installing Pages"
    chmod a+x pages/pages
    cp pages/pages /usr/local/bin >/dev/null 2>&1 || echo "Error, try running as sudo."
    exit 0
  elif [[ "$answer" != [Nn] ]]; then
    echo "Unknown answer, please try again."
    askInstall
  fi
}

askInstall
