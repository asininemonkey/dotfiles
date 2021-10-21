#!/usr/bin/env bash

find "${HOME}" -name ".terragrunt-cache"   -print0 | xargs -0 rm -fr

find "${HOME}" -name ".DS_Store"           -print0 | xargs -0 rm -fr
find "${HOME}" -name ".localized"          -print0 | xargs -0 rm -fr
find "${HOME}" -name ".terraform.lock.hcl" -print0 | xargs -0 rm -fr
find "${HOME}" -name ".zcompdump-*"        -print0 | xargs -0 rm -fr

find "/Applications" -name ".DS_Store"     -print0 | xargs -0 rm -fr
