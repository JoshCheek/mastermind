require 'mastermind/stats'

RSpec.describe Mastermind::Stats do
  describe 'correct_position' do
    def correct_position!(secret, guess, expected)
      actual = Mastermind::Stats.correct_position(secret, guess)
      expect(actual).to eq expected
    end

    it 'reports the number of colors in the correct position' do
      correct_position! "r", "r", 1
      correct_position! "g", "r", 0

      correct_position! "rrrr", "rrrr", 4
      correct_position! "grrr", "rrrr", 3
      correct_position! "rrrr", "grrr", 3
      correct_position! "ryyy", "yyyr", 2
    end
  end

  describe 'incorect_position' do
    def incorrect_position!(secret, guess, expected)
      actual = Mastermind::Stats.incorrect_position(secret, guess)
      expect(actual).to eq expected
    end

    it 'reports the number of colors in the incorrect position' do
      incorrect_position! "rg", "yr", 1
      incorrect_position! "gr", "ry", 1
      incorrect_position! "rryy", "rgrr", 1
      incorrect_position! "rrryybb", "rggrryr", 3 # 2 red, 1 yellow
    end

    it 'does not count colors in the correct position' do
      incorrect_position! "r", "r", 0
      incorrect_position! "ryg", "rgb", 1
      incorrect_position! "ryg", "rgy", 2
    end

    it 'does not count colors that have already been counted' do
      incorrect_position! "ryy", "grr", 1
      incorrect_position! "rgg", "grr", 2
      incorrect_position! "rryy", "rgrr", 1
      incorrect_position! "rrgg", "rgrr", 2
    end

    it 'does not count colors that don\'t match' do
      incorrect_position! "r", "g", 0
    end
  end
end
