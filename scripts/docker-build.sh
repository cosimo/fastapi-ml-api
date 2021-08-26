#!/usr/bin/env bash

set -e -x

PROJECT=myproject
IMAGE=${IMAGE:-your.docker.registry/$PROJECT}
TAG=${GITHUB_SHA:-main}

if [ -z "$VERSION" -a -e VERSION ] ; then
    VERSION=$(cat VERSION)
fi

docker build \
  --tag "${IMAGE}:${GITHUB_SHA}" \
  --build-arg GITHUB_SHA="$GITHUB_SHA" \
  --build-arg GITHUB_REF="$GITHUB_REF" \
  --build-arg VERSION="$VERSION" \
  .
