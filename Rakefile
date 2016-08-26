require 'rubygems/package'
require 'rubygems/commands/push_command'
VERSION = ENV['CIRCLE_TAG'].gsub("v", "") rescue '0.0.0'

task :push do
  %w(data.maybe data.either).each do |name|
    spec = Gem::Specification.new do |s|
      s.name        = name
      s.version     = VERSION
      s.summary     = "#{name} Data Type for Ruby"
      s.description = "lightweight #{name} Monad"
      s.authors     = ["Jichao Ouyang"]
      s.email       = 'oyanglulu@gmail.com'
      s.files       = ["lib/#{name}.rb",
                       "lib/helper.rb",
                       "lib/control/monad.rb"]
      s.homepage    =
        'https://github.com/jcouyang/cats.rb'
      s.license       = 'MIT'
      s.required_ruby_version = '>= 1.9.3'
    end
    Gem::Package.build spec
    push = Gem::Commands::PushCommand.new
    push.handle_options ["#{name}-#{VERSION}.gem"]
    push.execute
  end
end
