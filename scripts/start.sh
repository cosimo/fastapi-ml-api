#!/bin/bash

set -e -x

export JSON_LOGS=False

pushd src
uvicorn main:app --reload --host 127.0.0.1 --port 8887
popd
