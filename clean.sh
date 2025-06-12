#!/usr/bin/env bash

# Clean all the cache and binaries from projects

REPO_ROOT="$(dirname "$(realpath "$0")")"

rm -rvf $REPO_ROOT/*/\.zig-cache
rm -rvf wildcard $REPO_ROOT/*/zig-out
