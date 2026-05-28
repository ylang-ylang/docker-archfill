#!/usr/bin/env sh
set -eu

ref_name="${GITHUB_REF_NAME:-}"

case "$ref_name" in
  main|case/*/*) ;;
  "")
    echo "GITHUB_REF_NAME is required for scheduled release following" >&2
    exit 2
    ;;
  *)
    echo "scheduled release following is allowed only on main or case/*/*; current ref: $ref_name" >&2
    echo '{"include":[]}'
    exit 0
    ;;
esac

rows=""
for dir in recipes/*; do
  [ -d "$dir" ] || continue
  recipe="${dir#recipes/}"
  type="$(scripts/recipe-upstream-field.sh "$recipe" type 2>/dev/null || true)"
  if [ "$type" != "github_release" ]; then
    continue
  fi

  repo="$(scripts/recipe-upstream-field.sh "$recipe" repo)"
  version="$(scripts/github-latest-release.sh "$repo")"
  image="$(scripts/recipe-field.sh "$recipe" image)"
  case "$image" in
    CHANGE_ME|CHANGE_ME/*|*/CHANGE_ME)
      echo "skip $recipe: placeholder image" >&2
      continue
      ;;
  esac

  if scripts/docker-tag-exists.sh "$image" "$version"; then
    echo "skip $recipe: $image:$version already exists" >&2
    continue
  fi

  row="$(jq -nc --arg recipe "$recipe" --arg version "$version" '{recipe: $recipe, version: $version}')"
  rows="${rows}${rows:+,}$row"
done

printf '{"include":[%s]}\n' "$rows"

