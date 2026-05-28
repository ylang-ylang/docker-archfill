# archfill-smoke

Lightweight recipe used to test the generic Archfill build pipeline before
building heavier upstream projects.

It builds a tiny Alpine-based image for:

- `linux/amd64`
- `linux/arm64`

Run it with an image override, for example:

```bash
gh workflow run "Build Recipe" \
  -f recipe=archfill-smoke \
  -f version=0.1.0 \
  -f moving_tags=smoke \
  -f image_override=yourname/archfill-smoke
```

