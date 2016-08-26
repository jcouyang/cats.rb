#!/bin/bash
set -e
echo "---" > ~/.gem/credentials
echo ":rubygems_api_key: $RUBYGEMS_API" >> ~/.gem/credentials
chmod 600 ~/.gem/credentials
bundle exec rake push
