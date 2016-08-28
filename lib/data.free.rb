require 'control/monad'

# WIP
module Free
  include Control::Monad
  def initialize v=nil
    @v = v
  end
  
  def tail_recur_m a, &f
    f[a].flat_map do |either|
      either.when Left: -> a1 { tail_recur_m a1, &f},
                  Right: -> b { Return.new b }
    end
  end
  
  def fold_map a_to_m
    
  end

  # @return [String]
  def to_s
    case self
    when Roll
      "#<Roll #{@v}>"
    else
      "#<Return #{@v}>"
    end
  end
  alias_method :inspect, :to_s
end

# Roll (f (Free f a))
class Roll
  include Free
  def map &block
    Roll.new(@v.map { |free_f_a| free_f_a.map &block})
  end

  def flat_map &k
    Roll.new(@v.map { |free_f_a| free_f_a.flat_map &k})
  end

  def == other
    case other
    when Roll
      other.map { |v| map { |a| return a==v} }
    else
      false
    end
  end
end

class Return
  include Free
  def map
    Return.new(yield @v)
  end
  def flat_map
    yield @v
  end
  def == other
    case other
    when Return
      other.map { |v| return v == @v }
    else
      false
    end
  end
end
