![CI workflow](https://github.com/pekkaro/learn-bats/actions/workflows/test.yml/badge.svg)

# Learn-bats

This repo follows the tutorial for [bats-core](https://bats-core.readthedocs.io/en/stable/tutorial.html#).
The choice of tooling in the tutorial can cause some trouble as Ncat is not available on MacOS and is not installed by default on ubuntu images that Github actions use. I modified the code to make this work on my Mac and on Github Workflow. It will fail with slightly cryptic error messages if you don't have nc on Mac or Ncat or nc on Linux.
