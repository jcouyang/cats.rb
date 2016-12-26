require 'control/monad'
require 'union_type'
module Validated
  include Control::Applicative
  include UnionType

  def initialize v
    @v=v
  end
  def map
    case self
    when Valid
      Valid.new(yield @v)
    else
      self
    end
  end
  def self.product fa, fb
    fa.map(->(a){->(b){[a,b]}}).ap(fb)
  end
  
  def self.map2 v1, v2
    self.product(v1, v2).when(
      {
        Valid: ->(v){Valid.new(yield *v)},
        Invalid: ->(error){Invalide.new(error)}
      })
  end
  # def a; end
  # 
  def apply other
    self.when(
      {
        Invalid: ->(error1){
          other.when(
            {
              Invalid: ->(error2){ Invalid.new(error1 + error2) },
              _: ->(){ self }
            }
          )
        }
        Valid: ->(f){
          other.when(
            {
              Invalid: ->(error2){ other },
              Valid: ->(x){ Valid.new(f[x]) }
            }
          )
        }
      })
  end
end

class Valid
  include Validated
end

class Invalid
  include Validated
end
