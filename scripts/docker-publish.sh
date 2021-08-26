#!/usr/bin/env bash

set -e -x

echo "Pushing docker image ${IMAGE}:${GITHUB_SHA}"

docker push "${IMAGE}:${GITHUB_SHA}"

if [ -e VERSION ]; then
    VERSION=`cat VERSION`
    echo "Tagging ${IMAGE}:${GITHUB_SHA} as version ${VERSION}"
    docker tag "${IMAGE}:${GITHUB_SHA}" "${IMAGE}:${VERSION}"
    docker push "${IMAGE}:${VERSION}"
fi

BRANCH="${GITHUB_REF##*/}"
if [[ -n $BRANCH ]]; then
    echo "This is not a PR, so tagging ${IMAGE}:${GITHUB_SHA} as branch ${BRANCH}"
    docker tag "${IMAGE}:${GITHUB_SHA}" "${IMAGE}:${BRANCH}"
    docker push "${IMAGE}:${BRANCH}"
fi
