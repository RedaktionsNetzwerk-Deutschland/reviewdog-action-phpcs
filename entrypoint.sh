#!/bin/sh

cd "${GITHUB_WORKSPACE}" || exit

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

if [ ! -z "${INPUT_PHPCS_INSTALLED_PATHS}" ];then
  phpcs --config-set installed_paths ${INPUT_PHPCS_INSTALLED_PATHS}
fi

command_arguments="phpcs"
command_arguments="$command_arguments --report=checkstyle"

if [ -z "${INPUT_COMMAND_ARGS}" ];then
	if [ ! -z "${INPUT_MEMORY_LIMIT}" ];then
		command_arguments="$command_arguments -d memory_limit=${INPUT_MEMORY_LIMIT}"
	fi

	if [ ! -z "${INPUT_CODING_STANDARD}" ];then
		command_arguments="$command_arguments --standard=${INPUT_CODING_STANDARD}"
	fi
else
	command_arguments="$command_arguments ${INPUT_COMMAND_ARGS}"
fi


phpcs $command_arguments \
| reviewdog \
    -f="checkstyle" \
    -name="phpcs" \
    -reporter="${INPUT_REPORTER:-github-pr-check}" \
    -filter-mode="${INPUT_FILTER_MODE:-added}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR:-false}" \
    -level="${INPUT_LEVEL:-error}" \
    ${INPUT_REVIEWDOG_FLAGS:-}