#!/bin/bash

MSG=`git log --oneline --format=%B -n 1`

git reset --soft HEAD~1
git reset
git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -
git commit -m "$MSG"
git reset --hard
