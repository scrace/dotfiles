#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # check if running within WSL
  if [ -n "$WSL_DISTRO_NAME" ]; then
    for drive in {a..z}; do
      tmp=/mnt/$drive/
      if [ -d "$tmp" ] && ls "$tmp" | grep -q "Windows"; then
        USERNAME=$(powershell.exe '$env:UserName')
        HOME_DIR="$tmp"Users/"$USERNAME"
        break
      fi
    done
  else
    HOME_DIR="$HOME"
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  HOME_DIR="$HOME"
else
  echo "Unsupported OS"
  exit 1
fi


