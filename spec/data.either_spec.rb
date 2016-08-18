require_relative '../lib/data.either'
describe Either do
  it '#map' do
    expect(Right.new(1).map {|x| x + 1}).to eq(Right.new(2))
    expect(Left.new('hehe').map {|x| x + 1}).to eq(Left.new('hehe'))
  end

  it '#left_map' do
    expect(Right.new(1).left_map {|x| x + 1}).to eq(Right.new(1))
    expect(Left.new(1).left_map {|x| x + 1}).to eq(Left.new(2))
  end

  it '#bimap' do
    expect(Right.new(1).bimap ->(x){x-1}, ->(x){x+1}).to eq(Right.new(2))
    expect(Left.new(1).bimap ->(x){x-1}, ->(x){x+1}).to eq(Left.new(0))
  end

  it '#get_or_else' do
    expect(Right.new(1).get_or_else('')).to eq(1)
    expect(Left.new(1).get_or_else('')).to eq('')
  end

  it '#inspect' do
    expect(Right.new(1).inspect).to eq('#<Right value=1>')
    expect(Left.new(1).inspect).to eq('#<Left value=1>')
  end

  it '#bind' do
    expect(Right.new(1).bind { |x| Left.new } ).to eq(Left.new)
    expect(Left.new(1).bind { |x| Left.new } ).to eq(Left.new(1))
  end

  describe Right do
    it '#==' do
      expect(Right.new(1) == Left.new(1)).to be false
    end
  end

  describe Left do
    it '#==' do
      expect(Left.new(1) == Right.new(1)).to be false
    end
  end
end
