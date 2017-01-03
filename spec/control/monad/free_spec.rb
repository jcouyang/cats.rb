require 'spec_helper'
require 'data.maybe'
require 'control/monad/free'
describe Free do
  it 'free functor Free[F,A] -> (A -> Free[F, B]) -> Free[F, B]' do
    expect(Return.new(1).flat_map { |x| Return.new(x + 1) }).to eq(Return.new(2))
    expect(Roll.new(Just.new(Return.new(1))).flat_map { |x| Roll.new(Right.new(Return.new(x + 1))) })
      .to eq(Roll.new(Just.new(Roll.new(Right.new(Return.new(2))))))
  end
end
