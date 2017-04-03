#!/usr/bin/env bash
set -euo pipefail
set -x

CURRENT=$(git show-ref --hash --head HEAD)

finish() {
    rm -rf /tmp/2017.elm-conf.us
}
trap finish EXIT

git clone --branch gh-pages git@github.com:elm-conf-us/2017.elm-conf.us.git /tmp/2017.elm-conf.us
rsync --recursive --delete --verbose --exclude .git public/ /tmp/2017.elm-conf.us

cd /tmp/2017.elm-conf.us
git add --all :/

if [ "$(git status -s)" != "" ]; then
    git commit -m "published from ${CURRENT} by $(git config user.name) <$(git config user.email)>"
    git push
fi
