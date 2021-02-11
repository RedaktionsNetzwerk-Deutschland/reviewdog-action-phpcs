#!/bin/sh

cd "${GITHUB_WORKSPACE}" || exit

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

if [ "${INPUT_PHPCS_INSTALLED_PATHS}" != "" ];then
  phpcs --config-set installed_paths ${INPUT_PHPCS_INSTALLED_PATHS}
fi

phpcs -d memory_limit=${INPUT_MEMORY_LIMIT:-128m} ${INPUT_CODING_STANDARD:---standard=PSR12} --report=checkstyle \
| reviewdog \
    -f="checkstyle" \
    -name="phpcs" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -filter-mode="${INPUT_FILTER_MODE:-added}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR:-false}" \
    -level="${INPUT_LEVEL:-error}" \
    ${INPUT_REVIEWDOG_FLAGS:-}