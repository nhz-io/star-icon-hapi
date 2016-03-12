#!/bin/bash
if [ $(git rev-parse --abbrev-ref HEAD) != "master" ]; then exit 0; fi

set -e
rm -rf doc || exit 0

npm run doc
cd doc

git init

git config --local user.name "Travis CI"
git config --local user.email "dev@nhz.io"

git add . --all
git commit -m "Deploy to GitHub Pages"

git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
