#!/bin/bash
set -e

# Don't run tests on ARM (ARM builds already take a long time)
[[ "${ARCH}" == *"ARM"*   ]] && exit 0

# Can't test a Windows executable on a Linux box
[[ "${ARCH}" == *"mingw"* ]] && exit 0

# Test these...
case "${FLAVOR}" in
  "squeak"*|"pharo"*)
    "./tests/smalltalkCI.sh"
    ;;
  "newspeak"*)
    "./tests/newspeakBootstrap.sh"
    ;;
esac
