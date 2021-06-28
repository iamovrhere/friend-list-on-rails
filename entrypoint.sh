#!/bin/bash
# From: https://docs.docker.com/samples/rails/
set -e

TARGET_APP=${TARGET_APP:="friend-list-on-rails"}
# Remove a potentially pre-existing server.pid for Rails.
rm -f /$TARGET_APP/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
# Disabling exec for development purposes.
# exec "$@"

rails server -b 0.0.0.0
