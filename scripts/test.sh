#!/usr/bin/env bash

set -e -x

PYTEST_OPTS=''

if [[ $1 == '-v' ]]; then
    PYTEST_OPTS='-v'
elif [[ $1 == '-vv' ]]; then
    PYTEST_OPTS='-v -s'
fi

export PYTHONPATH=.
pushd src
pytest $PYTEST_OPTS ../tests
popd
