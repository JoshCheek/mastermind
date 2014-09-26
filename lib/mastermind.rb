require 'mastermind/stats'

class Mastermind
  def initialize(secret, valid_colors)
    self.secret        = secret
    self.guesses       = []
    self.valid_colors  = valid_colors
  end

  def guess(guess)
    guesses << guess
  end

  def num_turns
    guesses.size.next
  end

  def valid_guess?(guess)
    guess.length == secret.length &&
      guess.chars.all? { |color| valid_colors.include? color }
  end

  private

  attr_accessor :guesses, :secret, :valid_colors
end
