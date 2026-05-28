# feat/wet-run-test

- Add `archfill-smoke` as a lightweight multi-arch recipe.
- Add workflow `image_override` support so smoke tests can push to a temporary Docker Hub image.
- Keep SoftEther as a separate recipe for later real case work.
- Rename workflows to make manual and scheduled entry points explicit.
- Move release-following discovery logic from workflow YAML into recipe scripts.
- Limit scheduled release following to `main` and `case/*/*` refs.
