require 'helper'
module Control
  module Functor
    extend Helper
    def map
    end
  end

  module Monad
    extend Helper
    include Functor
    def >=
      raise '>= No defined'
    end

    alias_names([:flat_map], :>=) 
    
    def >> k
      self.>= { |_| k }
    end
  end

end
