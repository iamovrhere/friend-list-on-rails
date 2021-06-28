#!/bin/bash
# Quick script to get the server started.
set -e

export TARGET_APP='friend-list-on-rails';
export TARGET_DIR='./friend-list-on-rails'

is_installed () {
  # Colours: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  local RED='\033[0;31m'
  local NC='\033[0m'
  if ! which $1 > /dev/null; then
    printf "${RED}'$1' not found!${NC}\n"
  fi
}

is_installed docker
is_installed docker-compose

# docker-compose build
docker-compose up
