# Cats.rb

`Cats.rb` is a collection of Category Theory libs for Ruby. You'll find it very handy if you familiar with [Haskell](http://haskell.org/) or [scalaz](https://github.com/scalaz/scalaz)/[cats](https://github.com/typelevel/cats)

[![CircleCI](https://circleci.com/gh/jcouyang/cats.rb.svg?style=svg)](https://circleci.com/gh/jcouyang/cats.rb)
[![Document](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](https://oyanglul.us/cats.rb )
[![Coverage Status](https://coveralls.io/repos/github/jcouyang/cats.rb/badge.svg?branch=master)](https://coveralls.io/github/jcouyang/cats.rb?branch=master)
[![License](http://img.shields.io/badge/license-MIT-yellowgreen.svg)](#license)

:joy_cat: :arrow_right: :smirk_cat: <br/>
:arrow_down:  :arrow_lower_right: :arrow_down:<br/>
:scream_cat: :arrow_right: :heart_eyes_cat:

## data.either

[![Gem](https://img.shields.io/gem/v/data.either.svg?maxAge=2592000)](https://rubygems.org/gems/data.either)
[![Gem](https://img.shields.io/gem/dt/data.either.svg?maxAge=2592000)](https://rubygems.org/gems/data.either)
[![Document](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](https://oyanglul.us/cats.rb )

### install

``` sh
gem install data.either
```

### How to use
```ruby
require 'data.either'
Right.new(1).flat_map do |x| 
  if x < 1
    Left.new('meh')
  else
    Right.new(x+1)
  end
end
# => #<Right value=2>

Right.new(1) >> Left.new('oops') >> Right.new(1) # => #<Left value=oops>
```

more detail on [![Document](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](https://oyanglul.us/cats.rb )


## data.maybe

[![Gem](https://img.shields.io/gem/v/data.maybe.svg?maxAge=2592000)](https://rubygems.org/gems/data.maybe)
[![Gem](https://img.shields.io/gem/dt/data.maybe.svg?maxAge=2592000)](https://rubygems.org/gems/data.maybe)


### install

``` sh
gem install data.maybe
```

### How to use
```ruby
require 'data.either'
Just.new(1).flat_map do |x| 
  if x < 1
    Nothing
  else
    Just.new(x+1)
  end
end
# => #<Just 2>

Maybe.new(1) >> Nothing >> Maybe.new(2) # => #<Nothing>
```
## WIP

### control.monad.free

#### install
``` sh
gem install control.monad.free
```

#### How to use
``` ruby
Roll.new(Just.new(Return.new(1))).flat_map { |x| Return.new(x + 1) }
# => #<Roll #<Just #<Return 2>>>
```

### control.exception
### to be continue...
