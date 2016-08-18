# a very simple Either
module Either
  def initialize v
    @v = v
  end

  def get_or_else e
    case self
      when Right
        @v
      else
        e
    end
  end

  # Functor
  def map
    case self
    when Right
      Right.new(yield @v)
    else
      self
    end
  end
  
  alias :fmap :map
  
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

  # Monad
  def bind
    case self
    when Right
      yield @v
    else
      self
    end
  end

  alias :chain :bind
  alias :flat_map :bind

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
  def == other
    case other
    when Right
      other.map { |v| return v == @v }
    else
      false
    end
  end
end
