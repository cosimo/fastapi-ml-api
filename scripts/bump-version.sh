#!/bin/bash

set -e -x

CURRENT=$(git ls-remote --refs --tags origin | cut -d/ -f3- | sort --version-sort | tail -n1 | cut -c2-)
echo Current version: $CURRENT

NEXT=$(echo $CURRENT \
	| awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{$NF=sprintf("%0*d", length($NF), ($NF+1)); print}')

echo Next version: $NEXT

echo $NEXT > VERSION
echo VERSION=$NEXT >> $GITHUB_ENV
