#!/bin/bash

set -euo pipefail

EXPECTED_VERSION="${1:-${VERSION:-}}"

CHART_VERSION="$(sed -n -E 's/^version:[[:space:]]*//p' chart/Chart.yaml | head -n1)"
CHART_APP_VERSION="$(sed -n -E 's/^appVersion:[[:space:]]*//p' chart/Chart.yaml | head -n1)"
VALUES_IMAGE_TAG="$(sed -n -E 's/^[[:space:]]*tag:[[:space:]]*//p' chart/values.yaml | head -n1)"

if [[ -z "${CHART_VERSION}" || -z "${CHART_APP_VERSION}" || -z "${VALUES_IMAGE_TAG}" ]]; then
  echo "Failed to read release versions from chart/Chart.yaml or chart/values.yaml"
  exit 1
fi

if [[ "${VALUES_IMAGE_TAG}" != "${CHART_VERSION}" || "${VALUES_IMAGE_TAG}" != "${CHART_APP_VERSION}" ]]; then
  echo "Release version mismatch detected:"
  echo "  chart/values.yaml image.tag=${VALUES_IMAGE_TAG}"
  echo "  chart/Chart.yaml version=${CHART_VERSION}"
  echo "  chart/Chart.yaml appVersion=${CHART_APP_VERSION}"
  exit 1
fi

if [[ -n "${EXPECTED_VERSION}" && "${EXPECTED_VERSION}" != "${VALUES_IMAGE_TAG}" ]]; then
  echo "Release version does not match chart values:"
  echo "  expected version=${EXPECTED_VERSION}"
  echo "  chart/values.yaml image.tag=${VALUES_IMAGE_TAG}"
  exit 1
fi
