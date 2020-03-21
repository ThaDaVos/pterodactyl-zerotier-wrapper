#!/bin/sh

export IMAGE_FROM_SOURCE="$@";

envsubst '${IMAGE_FROM_SOURCE}' < ./Dockerfile.template > ./Dockerfile