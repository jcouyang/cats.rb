require 'control.monad'
module Either
  extend Monad
  def initialize v
    @v = v
  end

  def left?
    false
  end

  def right?
    false
  end
  
  def get_or_else e
    case self
      when Right
        @v
      else
        e
    end
  end

  def map
    case self
    when Right
      Right.new(yield @v)
    else
      self
    end
  end
  
  def left_map
    case self
    when Left
      Left.new(yield @v)
    else
      self
    end
  end

  def bimap lfn, rfn
    case self
      when Right
        Right.new(rfn.(@v))
      else
        Left.new(lfn.(@v))
    end
  end

  def bind
    case self
    when Right
      yield @v
    else
      self
    end
  end

  # [Either a b] -> [b]
  def rights list_of_either
    list_of_either.select(&:right?)
      .map { |right| right.get_or_else(nil) }
  end

  # [Either a b] -> [a]
  def left list_of_either
    list_of_either.select(&:left?)
      .map { |left| left.when({Left: ->l{l}}) }
  end

  def when what
    current_class = self.class.to_s.to_sym
    if what.include? current_class
      what[current_class].(@v)
    elsif what.include? :_
      what[:_].(@v)
    end
  end
    
  def inspect
    case self
    when Left
      "#<Left value=#{@v}>"
    else
      "#<Right value=#{@v}>"
    end
  end
end

class Left
  include Either  
  def initialize v=nil
    @v=v
  end

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
