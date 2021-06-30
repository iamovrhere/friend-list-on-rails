#!/bin/bash
# Quick script to get the server started.
set -e

is_installed () {
  # Colours: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  local RED='\033[0;31m';
  local NC='\033[0m';
  if ! which $1 > /dev/null; then
    printf "${RED}'$1' not found!${NC}\n";
    exit 1;
  fi
}

is_installed docker;
is_installed docker-compose;


export TARGET_APP='friend-list-on-rails';
export TARGET_DIR='./friend-list-on-rails';
export TARGET_LAYER=$1;

if [ "$2" == "--build" ]; then
  docker-compose build;
fi

case $1 in
  dev)
    ;;
  prod)
    ;;

  *)
    echo "Required environment!";
    echo "Supports 'dev' or 'prod'";
    exit 1;
    ;;
esac

docker-compose up;
