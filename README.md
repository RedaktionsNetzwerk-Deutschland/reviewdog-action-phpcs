# reviewdog-action-php

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/RedaktionsNetzwerk-Deutschland/reviewdog-action-phpcs?logo=github&sort=semver)](https://github.com/RedaktionsNetzwerk-Deutschland/reviewdog-action-phpcs/releases)

This action runs [phpcs](https://github.com/squizlabs/PHP_CodeSniffer) with [reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve code review experience.


## Input

```yaml
inputs:
  github_token:
    description: 'GITHUB_TOKEN.'
    default: '${{ github.token }}'
  level:
    description: 'Report level for reviewdog [info,warning,error]'
    default: 'error'
  reporter:
    description: |
      Reporter of reviewdog command [github-pr-check,github-pr-review,github-check].
      Default is github-pr-check.
      github-pr-review can use Markdown and add a link to rule page in reviewdog reports.
    default: 'github-pr-check'
  filter_mode:
    description: |
      Filtering mode for the reviewdog command [added,diff_context,file,nofilter].
      Default is added.
    default: 'added'
  fail_on_error:
    description: |
      Exit code for reviewdog when errors are found [true,false]
      Default is `false`.
    default: 'false'
  reviewdog_flags:
    description: 'Additional reviewdog flags'
    default: ''
  memory_limit:
    description: |
      set the php memory_limit for phpcs
      Default is `128m`.
    default: '128m'
  phpcs_installed_paths:
    description: |
      set additional paths for phpcs
      Default is ``.
    default: ''
  coding_standard:
    description: |
      set the coding standard check for phpcs
      Default is `PSR12`.
    default: 'PSR12'
```

## Usage

```yaml
name: reviewdog
on: [pull_request]
jobs:
  phpcs:
    name: phpcs
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: RedaktionsNetzwerk-Deutschland/reviewdog-action-phpcs@v1
        with:
          github_token: ${{ secrets.github_token }}
          # Change reviewdog reporter if you need [github-pr-check,github-check,github-pr-review].
          reporter: github-pr-review
          # Report all results.
          filter_mode: nofilter
          # Exit with 1 when it find at least one finding.
          fail_on_error: true
```

___

♥ RND Technical Hub