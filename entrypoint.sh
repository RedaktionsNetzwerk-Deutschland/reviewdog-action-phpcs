#!/bin/sh

cd "${GITHUB_WORKSPACE}" || exit

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

phpcs --report=checkstyle \
| reviewdog \
    -f="checkstyle" \
    -name="phpcs" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -filter-mode="${INPUT_FILTER_MODE:-added}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR:-false}" \
    -level="${INPUT_LEVEL:-error}" \
    ${INPUT_REVIEWDOG_FLAGS:-}