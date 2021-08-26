#!/usr/bin/env bash

set -e -x

PROJECT=myproject
IMAGE=${IMAGE:-your.docker.registry/$PROJECT}
TAG=${GITHUB_SHA:-main}

#docker pull "${IMAGE}:${TAG}"
docker run --shm-size=1.75G --rm "${IMAGE}:${TAG}" /usr/local/bin/pytest -v /tests
exit_status=$?

echo Tests exit status: $exit_status
exit $exit_status
