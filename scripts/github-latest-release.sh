#!/usr/bin/env sh
set -eu

repo="${1:?usage: github-latest-release.sh <owner/repo>}"

curl -fsSL \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$repo/releases/latest" \
  | jq -r '.tag_name'

