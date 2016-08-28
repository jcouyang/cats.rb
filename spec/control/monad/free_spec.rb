require 'spec_helper'
require 'data.maybe'
require 'control/monad/free'
describe Free do
  it 'free functor' do
    expect(Return.new(1).flat_map { |x| Just.new(x+1) }).to eq(Just.new(2))
    expect(Roll.new(Just.new(Return.new(1))).flat_map { |x| Return.new(x + 1) })
      .to eq(Roll.new(Just.new(Return.new(2))))
  end
end
