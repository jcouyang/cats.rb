require 'control/monad'
require 'singleton'
require 'union_type'
# The `Either` union type represents values with two possibilities:
#
# `Either a b` is either `Left a` or `Right b`
module Maybe
  include Control::Monad
  include UnionType
  # Either only contain one value @v
  # @return [Either]
  def initialize v=nil
    @v = v
  end

  # get value `a` out from `Right a`, otherwise return `e`
  def get_or_else e
    case self
      when Just
        @v
      else
        e
    end
  end

  # overide of Functor's `fmap`, apply function on `Right a`'s value `a`, do nothing if it's `Left e`
  #
  # ``` ruby
  #   Right.new(1).map {|x| x + 1} # => #<Right value=2>
  #   Left.new(1).map {|x| x + 1} # => #<Left value=1>
  # ```
  # @return [Either]
  def map
    case self
    when Just
      Just.new(yield @v)
    else
      self
    end
  end
  
  # it override {Monad#flat_map}, as Haskell's `>flat_map` method
  # if it's {Right}, pass the value to #flat_map's block, and flat the result
  # of the block.
  #
  # when it's {Left}, do nothing
  # ``` ruby
  # expect(Right.new(1).flat_map { |x| Left.new } ).to eq(Left.new)
  # expect(Left.new(1).flat_map { |x| Left.new } ).to eq(Left.new(1))
  # ```
  # @return [Either]
  def flat_map
    case self
    when Just
      yield @v
    else
      self
    end
  end

  # similar to Scala's `match` for case class
  #
  # will pattern match the value out and pass to matched lambda
  #
  # ``` ruby
  # Right.new(1).when({Right: ->x{x+1} }) # => 2
  # Right.new(1).when({Left: ->x{x+1}) # => nil
  # Right.new(1).when({Left: ->x{x+1}, _: ->x{x-1} }) # => 0
  # ```
  # @return [Either]
  def when what
    current_class = self.class.to_s.to_sym
    if what.include? current_class
      what[current_class].(@v)
    elsif what.include? :_
      what[:_].(@v)
    end
  end

  # @return [String]
  def inspect
    case self
    when Just
      "#<Just #{@v}>"
    else
      "#<Nothing>"
    end
  end
end


class Nothing
  include Singleton
  include Maybe
 
  def == other
    case other
    when Nothing
      true
    else
      false
    end
  end
end

Nothing = Nothing.instance

class Just
  include Maybe
  
  def == other
    case other
    when Just
      other.map { |v| return v == @v }
    else
      false
    end
  end
end
