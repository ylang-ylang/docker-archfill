#!/usr/bin/env sh
set -eu

recipe="${1:?usage: recipe-metadata.sh <recipe>}"
version="${2:-}"
moving_tags="${3:-}"

image="$(scripts/recipe-field.sh "$recipe" image)"
dockerfile="$(scripts/recipe-field.sh "$recipe" dockerfile)"
context="$(scripts/recipe-field.sh "$recipe" context)"
version_arg="$(scripts/recipe-field.sh "$recipe" version_arg)"
platforms="$(scripts/recipe-list-field.sh "$recipe" platforms | paste -sd, -)"

if [ "$image" = "CHANGE_ME/softether-vpnserver" ]; then
  echo "recipe $recipe has placeholder image; edit recipes/$recipe/recipe.yaml" >&2
  exit 2
fi

if [ -z "$moving_tags" ]; then
  moving_tags="$(scripts/recipe-list-field.sh "$recipe" moving_tags | paste -sd, -)"
fi

tags="$image:$version"
old_ifs="$IFS"
IFS=","
for tag in $moving_tags; do
  if [ -n "$tag" ]; then
    tags="$tags,$image:$tag"
  fi
done
IFS="$old_ifs"

{
  echo "image=$image"
  echo "dockerfile=recipes/$recipe/$dockerfile"
  echo "context=recipes/$recipe/$context"
  echo "version_arg=$version_arg"
  echo "platforms=$platforms"
  echo "tags=$tags"
}

