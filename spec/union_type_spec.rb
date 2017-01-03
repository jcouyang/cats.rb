require_relative 'spec_helper'
describe UnionType do
    class H
      include UnionType
    end
    it 'multiple values can be case' do
      H.new(1,2).when H:->(v1,v2){
        expect(v1).to be(1)
        expect(v2).to be(2)
      }
    end
    it 'single value can be case' do
      H.new(1).when H:->(v1){
        expect(v1).to be(1)
      }
    end
end
