## Release Instructions

### 1. Set the release version
Use semver for stable releases (example: `1.20.0`) and `-rcNN` for release candidates (example: `1.20.0-rc04`).

```bash
export T=1.20.0-rc04
```

### 2. Update Helm chart version fields
This updates `chart/values.yaml` image tag and `chart/Chart.yaml` version/appVersion.

```bash
make VERSION=$T prepare-helm
```

### 3. Validate version consistency

```bash
./scripts/validate-release-version.sh "$T"
```

### 4. Commit release version changes

```bash
git commit -a -m "releasing $T"
```

### 5. Create and push the tag
Tag push triggers `.github/workflows/release-tag.yml`.

```bash
git tag "$T"
git push origin "$T"
```

### 6. Verify release workflow
Confirm the GitHub Actions run for the pushed tag completed successfully and published artifacts to the configured registry target.

## One-liner (equivalent flow)

```bash
export T=1.20.0-rc04 && \
make VERSION=$T prepare-helm && \
./scripts/validate-release-version.sh "$T" && \
git commit -a -m "releasing VERSION=$T" && \
git tag "$T" && \
git push origin "$T"
```
