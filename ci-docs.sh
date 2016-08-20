#!/bin/sh
set -e
git clone git@github.com:$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME.git -b gh-pages doc
bundle exec yardoc lib/data.either.rb lib/control/*.rb
git config --global user.name "circle ci"
git config --global user.email "oyanglulu@gmail.com"
cd doc
git add .
git commit -m "docs publi:ship: [ci skip]"
git push origin gh-pages
