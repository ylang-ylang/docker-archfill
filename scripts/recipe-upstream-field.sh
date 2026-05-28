#!/usr/bin/env sh
set -eu

recipe="${1:?usage: recipe-upstream-field.sh <recipe> <field>}"
field="${2:?usage: recipe-upstream-field.sh <recipe> <field>}"
file="recipes/$recipe/recipe.yaml"

if [ ! -f "$file" ]; then
  echo "recipe not found: $recipe" >&2
  exit 2
fi

awk -v field="$field" '
  /^upstream:[[:space:]]*$/ {
    in_upstream = 1
    next
  }
  in_upstream && /^[^[:space:]]/ {
    exit
  }
  in_upstream && $0 ~ "^[[:space:]]*" field ":[[:space:]]*" {
    sub("^[[:space:]]*" field ":[[:space:]]*", "")
    print
    found = 1
    exit
  }
  END {
    if (!found) exit 1
  }
' "$file"

