require 'mastermind'

RSpec.describe Mastermind do
  it 'knows how many turns have been taken' do
    m = Mastermind.new("rrrr", ['r'])
    expect(m.num_turns).to eq 1
    m.guess "gggg"
    expect(m.num_turns).to eq 2
    m.guess "gggg"
    m.guess "gggg"
    expect(m.num_turns).to eq 4
  end
end
