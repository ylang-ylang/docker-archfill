#!/usr/bin/env sh
set -eu

recipe="${1:?usage: recipe-build-bake.sh <recipe> <version> [moving_tags] [image_override]}"
version="${2:?usage: recipe-build-bake.sh <recipe> <version> [moving_tags] [image_override]}"
moving_tags="${3:-}"
image_override="${4:-}"

scripts/recipe-metadata.sh "$recipe" "$version" "$moving_tags" "$image_override"

