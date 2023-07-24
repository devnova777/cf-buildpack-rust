#!/bin/bash

# Standard paranoia
set -euo pipefail

# Get an example program for testing if we don't have one yet.
if [ ! -d ./cf-buildpack-rust-actix-test ]
then
  git clone https://github.com/lighthouse-no/cf-buildpack-rust-actix-test.git
fi

# Export the current UID so that our child processes can see it.
# This will be used as a parameter in our `docker-compose-test.yml` file.
export UID GROUPS

# test the buildpack functionality using `docker-compose`.
docker-compose -f test-buildpack.yml up
