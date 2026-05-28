# Archfill

Archfill contains Docker build recipes for upstream projects that do not publish
complete multi-architecture images.

The repository is generic by design:

- each image lives under `recipes/<name>/`
- each recipe declares its upstream source and Docker Hub target
- GitHub Actions can build a single recipe manually
- scheduled workflows can follow upstream GitHub releases

## Current Recipes

| Recipe | Upstream | Image |
| --- | --- | --- |
| `softether-vpnserver` | `SoftEtherVPN/SoftEtherVPN_Stable` | set in `recipes/softether-vpnserver/recipe.yaml` |

## Required Secrets

Set these repository secrets before pushing images:

```text
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
```

`DOCKERHUB_TOKEN` should be a Docker Hub access token.

## Manual Build

Run the `Build Recipe` workflow with:

```text
recipe: softether-vpnserver
version: v4.43-9799-rtm
moving_tags: stable,latest
```

The workflow builds:

```text
linux/amd64
linux/arm64
```

and pushes:

```text
<image>:<version>
<image>:stable
<image>:latest
```

## Follow Releases

The `Follow Releases` workflow checks recipes with `upstream.type:
github_release`. If `<image>:<latest-release-tag>` already exists, it skips the
build. If the tag does not exist, it builds and pushes the version tag and the
recipe's moving tags.

## Add A Recipe

Create:

```text
recipes/<name>/Dockerfile
recipes/<name>/recipe.yaml
```

The first supported upstream type is `github_release`.

Minimal `recipe.yaml`:

```yaml
name: my-image
image: yourname/my-image
dockerfile: Dockerfile
context: .
version_arg: UPSTREAM_VERSION
platforms:
  - linux/amd64
  - linux/arm64
upstream:
  type: github_release
  repo: owner/repo
moving_tags:
  - latest
```

