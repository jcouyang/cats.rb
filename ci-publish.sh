echo "---" > ~/.gem/credentials
echo ":rubygems_api_key: $RUBYGEMS_API" >> ~/.gem/credentials
chmod 600 ~/.gem/credentials
VERSION=$(sed "s/v//" <<< $CIRCLE_TAG)
gem build data.either/data.either.gemspec
gem push data.either/data.either-$VERSION.gem
