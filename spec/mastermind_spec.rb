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

  it 'knows if it has been won' do
    m = Mastermind.new("r", ['r', 'g'])
    expect(m).to_not be_won
    m.guess("g")
    expect(m).to_not be_won
    m.guess("r")
    expect(m).to be_won
  end


  context 'valid_guess?' do
    def assert_valid(secret, guess, valid_colors)
      m = Mastermind.new(secret, valid_colors)
      expect(m.valid_guess? guess).to eq true
    end

    def refute_valid(secret, guess, valid_colors)
      m = Mastermind.new(secret, valid_colors)
      expect(m.valid_guess? guess).to eq false
    end

    it 'is invalid for the wrong length' do
      refute_valid "r",   "rr", ['r']
      refute_valid "rrr", "rr", ['r']
      assert_valid "rr",  "rr", ['r']
    end

    it 'is invalid if any of the guess colors are not in the valid colors' do
      assert_valid "rr",  "rr", ['r']
      refute_valid "rr",  "rr", ['g']

      refute_valid "rr",  "gr", ['g']
      refute_valid "rr",  "rg", ['g']

      assert_valid "rr",  "yy", ['g', 'y']
      assert_valid "rr",  "gy", ['g', 'y']
      assert_valid "rr",  "yg", ['g', 'y']
      refute_valid "rr",  "rg", ['g', 'y']
      refute_valid "rr",  "gr", ['g', 'y']
    end
  end
end
