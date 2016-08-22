require 'helper'
module Control
  module Functor
    extend Helper
    def map
      raise 'map No defined'
    end
  end

  module Monad
    extend Helper
    include Functor
    def flat_map
      raise 'flat_map No defined'
    end
    
    def >> k
      self.flat_map { |_| k }
    end
  end

end
