#!/bin/bash
# From: https://docs.docker.com/samples/rails/
set -e

RED='\033[0;31m'
NC='\033[0m'

TARGET_APP=${TARGET_APP:="friend-list-on-rails"}
# Remove a potentially pre-existing server.pid for Rails.
rm -f /$TARGET_APP/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
