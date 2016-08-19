module Functor
  # (a -> b) -> f a -> f b
  def map
  end
  alias :fmap :map
end

module Monad
  extend Functor
  def bind
  end
  alias :chain :bind
  alias :flat_map :bind

  def >> k
    flat_map { |_| k }
  end
end
