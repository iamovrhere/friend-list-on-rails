#!/bin/bash
# Quick script to get into the container.
set -e

RED='\033[0;31m'
NC='\033[0m'

CONTAINER='friend-list-on-rails_web_1'
DEV_USER='developer'

if ! docker ps | grep $CONTAINER; then
  printf "${RED}Service '$CONTAINER' not found.\n"
  printf "Did remember to run ./run.sh?${NC}\n"
  exit 1
fi

# Preserves permissons for Docker in linux.
docker exec $CONTAINER adduser \
  --disabled-password \
  --gecos "Developer" \
  --shell /bin/bash \
  -u $UID $DEV_USER || true
docker exec -it $CONTAINER bash -c "echo '' && ruby --version && rails --version" || true
# Need to be root to handle some Gem stuff.
docker exec -it $CONTAINER bash # su $DEV_USER
