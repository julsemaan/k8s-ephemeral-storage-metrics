## Release Instructions (Image Only)

### 1. Pick the release tag
Use semver (`X.Y.Z`) for stable releases and `X.Y.Z-rcNN` for release candidates.

```bash
export T=1.20.0
```

### 2. Commit any pending release changes

```bash
git commit -a -m "release $T"
```

### 3. Create and push the tag
Pushing the tag triggers `.github/workflows/release-tag.yml`.

```bash
git tag "$T"
git push origin "$T"
```

### 4. Verify the workflow run
Check the GitHub Actions run for that tag completed and image artifacts were pushed.

## Registry Configuration

- Docker Hub is the only supported release registry.
- Set `DOCKER_USERNAME` and `DOCKER_PASSWORD` secrets.
