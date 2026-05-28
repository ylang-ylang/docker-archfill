#!/usr/bin/env sh
set -eu

recipe="${1:?usage: recipe-list-field.sh <recipe> <field>}"
field="${2:?usage: recipe-list-field.sh <recipe> <field>}"
file="recipes/$recipe/recipe.yaml"

if [ ! -f "$file" ]; then
  echo "recipe not found: $recipe" >&2
  exit 2
fi

awk -v field="$field" '
  $0 ~ "^[[:space:]]*" field ":[[:space:]]*$" {
    in_list = 1
    next
  }
  in_list && /^[^[:space:]]/ {
    exit
  }
  in_list && /^[[:space:]]*-[[:space:]]*/ {
    sub("^[[:space:]]*-[[:space:]]*", "")
    print
  }
' "$file"

