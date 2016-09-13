require 'helper'
module Control
  module Functor
    extend Helper
    def map
      raise 'map No defined'
    end
    alias_names [:fmap], :map
  end

  module Monad
    extend Helper
    include Functor
    def flat_map
      raise 'flat_map No defined'
    end

    alias_names [:bind, :chain], :flat_map
    
    def >> k
      self.flat_map { |_| k }
    end
  end
end
