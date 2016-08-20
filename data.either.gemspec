VERSION = ENV['CIRCLE_TAG'].gsub("v", "") || '0.0.0'
Gem::Specification.new do |s|
  s.name        = 'data.either'
  s.version     = VERSION
  s.summary     = "Either Data Type for Ruby"
  s.description = "The Either Monad"
  s.authors     = ["Jichao Ouyang"]
  s.email       = 'oyanglulu@gmail.com'
  s.files       = ["lib/data.either.rb",
                   "lib/helper.rb",
                   "lib/control/monad.rb"]
  s.homepage    =
    'https://github.com/jcouyang/cats.rb'
  s.license       = 'MIT'
  s.required_ruby_version = '>= 1.9.0'
end
