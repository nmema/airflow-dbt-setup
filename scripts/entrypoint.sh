#!/bin/bash

# Run base image entrypoint
/usr/bin/dumb-init -- /entrypoint "$@"