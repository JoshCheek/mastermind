require 'mastermind/stats'
require 'mastermind/secret_generator'

class Mastermind
  attr_reader :valid_colors

  def initialize(secret, valid_colors)
    self.secret        = secret
    self.guesses       = []
    self.valid_colors  = valid_colors
  end

  def guess(guess)
    guesses << guess
  end

  def turns_taken
    guesses.size
  end

  def valid_guess?(guess)
    guess.length == secret.length &&
      guess.chars.all? { |color| valid_colors.include? color }
  end

  def won?
    guesses.last == secret
  end

  private

  attr_accessor :guesses, :secret
  attr_writer :valid_colors
end
