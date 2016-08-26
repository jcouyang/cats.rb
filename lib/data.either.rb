require 'control/monad'

# The `Either` union type represents values with two possibilities:
#
# `Either a b` is either `Left a` or `Right b`
module Either
  include Comparable
  include Control::Monad

  # Either only contain one value @v
  # @return [Either]
  def initialize v=nil
    @v=v
  end

  # default `false`, should override in {Left} or {Right}
  # @return [Boolean]
  def left?
    false
  end
  # (see #left?)
  def right?
    false
  end

  # get value `a` out from `Right a`, otherwise return `e`
  # ```ruby
  # Right.new(1).get_or_else(2) # => 1
  # Right.new(1) | 2 # => 1
  # ```
  def get_or_else e
    case self
      when Right
        @v
      else
        e
    end
  end

  alias_method :|, :get_or_else

  def or_else e
    case self
      when Right
        
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
    when Right
      Right.new(yield @v)
    else
      self
    end
  end
  # the opposit of #map, apply function to `Left e`, do nothing if it's `Right a`
  #
  # ``` ruby
  #   Right.new(1).left_map {|x| x + 1} # => #<Right value=1>
  #   Left.new(1).left_map {|x| x + 1} # => #<Left value=2>
  # ```
  # @return [Either]
  def left_map
    case self
    when Left
      Left.new(yield @v)
    else
      self
    end
  end

  # `bimap` accept 2 lambdas, if it's [Right], apply the 2nd lambda, otherwise apply to the first lambda
  #
  # ``` ruby
  #   Right.new(1).bimap ->(x){x-1}, ->(x){x+1} # => 2
  #   Left.new(1).bimap ->(x){x-1}, ->(x){x+1}) # => 0
  # ```
  # @return [Either]  
  def bimap lfn, rfn
    case self
      when Right
        Right.new(rfn.(@v))
      else
        Left.new(lfn.(@v))
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
    when Right
      yield @v
    else
      self
    end
  end

  # similar to Scala's `match` for case class
  #
  # will pattern match the value out and pass to matched lambda
  # ```ruby
  # Right.new(1).when({Right: ->x{x+1} }) # => 2
  # Right.new(1).when({Left: ->x{x+1}) # => nil
  # Right.new(1) =~ ({Left: ->x{x+1}, _: ->x{x-1} }) # => 0
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

  alias_method :match, :when
  alias_method :=~, :when

  # swap type of [Either]
  #
  # ```ruby
  #  ~Right.new(1) # => Left.new(1)
  #  ~Left.new(2) # => Right.new(2)
  # ```
  # @return [Either]
  def ~@
    case self
    when Right
      Left.new @v
    else
      Right.new @v
    end
  end

  alias_method :swap, :~@
  def each &block
    bimap(->_{}, &blcok)
  end

  def to_a
    case self
    when Right
      [@v]
    else
      []
    end
  end

  # comparable
  # - Left < Right
  def <=> other
    case self
    when Right
      other =~ {Right: ->o{ @v <=> o},
                Left: ->_{1}}
    else
      other =~ {Right: ->_{ -1 },
                Left: ->o{ @v <=> o}}
    end
  end
  
  # @return [String]
  def inspect
    case self
    when Left
      "#<Left value=#{@v}>"
    else
      "#<Right value=#{@v}>"
    end
  end

  class << self
    # filter only {Right} value from List of {Either}
    #
    # ``` ruby
    # Either.rights [Left.new(1),Right.new(5), Right.new(2)] # => [5, 2]
    # ```
    # @return [value]
    def rights list_of_either
      list_of_either.select(&:right?)
        .map { |right| right.get_or_else(nil) }
    end

    # filter only {Left} value from List of {Either}
    #
    # ``` ruby
    # Either.lefts [Left.new(1),Right.new(5), Right.new(2)] # => [1]
    # ```
    # @return [value]
    def lefts list_of_either
      list_of_either.select(&:left?)
        .map { |left| left.when({Left: ->l{l}}) }
    end

    # partion a List of {Either} into a List of 2 List, one contains only {Left}, other contains only {Right}
    #
    # ``` ruby
    # Either.partition [Left.new(1),Right.new(5), Right.new(2)]  # => [[1],[5, 2]]
    # ```
    # @return [[l],[r]]
    def partition list_of_either
      list_of_either.inject([[],[]]) do |acc, x|
        x.when({
                 Left: ->(l){acc[0].push(l)},
                 Right: ->(r){acc[1].push(r)}
               })
        acc
      end
    end
  end
  
end


class Left
  include Either  

  # always true
  # @return [Boolean]
  def left?
    true
  end
  
  def == other
    case other
    when Left
      other.left_map { |v| return v == @v }
    else
      false
    end
  end
end

class Right
  include Either
  
  # always true
  # @return [Boolean]
  def right?
    true
  end
  
  def == other
    case other
    when Right
      other.map { |v| return v == @v }
    else
      false
    end
  end
end
