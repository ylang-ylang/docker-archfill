#!/usr/bin/env sh
set -eu

image="${1:?usage: docker-tag-exists.sh <image> <tag>}"
tag="${2:?usage: docker-tag-exists.sh <image> <tag>}"

docker buildx imagetools inspect "$image:$tag" >/dev/null 2>&1

