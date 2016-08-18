VERSION = ENV['CIRCLE_TAG'] || 0.1.dev
Gem::Specification.new do |s|
  s.name        = 'data.either'
  s.version     = VERSION
  s.summary     = "Either Data Type for Ruby"
  s.description = "The Either Monad"
  s.authors     = ["Jichao Ouyang"]
  s.email       = 'oyanglulu@gmail.com'
  s.files       = ["lib/either.rb"]
  s.homepage    =
    'https://github.com/jcouyang/cats.rb'
  s.license       = 'MIT'
end
