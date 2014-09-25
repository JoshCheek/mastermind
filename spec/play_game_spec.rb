require 'spec_helper'
require 'mastermind/cli/play_game'

RSpec.describe Mastermind::CLI::PlayGame do
  def after_running(options)
    secret       = options.fetch :secret, "r"
    input        = options.fetch :input,  "r"
    valid_colors = options.fetch :valid,  ["r", "g", "b", "y"]

    interact = MockInteract.new(input)
    Mastermind::CLI::PlayGame.call interact, secret, valid_colors
    interact
  end

  context 'when there is no input' do
    def after_running
      super input: nil, valid: ['r']
    end

    # TODO: needs to know what turn I'm on
    it 'does not continue prompting for a guess' do
      after_running.assert_told_to :prompt_guess, 1
    end

    it 'exits the game with a cant continue message'
    it 'does not prin last guess stats'
    it 'does not print invalid input message'
    it 'does not print the win message'
  end

  context 'when my guess is invalid' do
    def after_running
      super input: "z", valid: ['r']
    end

    it 'continues prompting for input' do
      after_running.assert_told_to :prompt_guess, 2
    end

    it 'does not increment my turn'
    it 'does not say it cant continue'
    it 'does not prin last guess stats'
    it 'does not print invalid input message'
    it 'does not print the win message'
  end

  context 'when my guess is incorrect' do
    def after_running
      super secret: "g", input: "r", valid: ['r', 'g']
    end

    it 'continues prompting for input' do
      after_running.assert_told_to :prompt_guess, 2
    end

    it 'increments my turn'
    it 'does not say it cant continue'
    it 'prints last guess stats'
    it 'does not print invalid input message'
    it 'does not print the win message'
  end

  context 'when my guess is correct' do
    def after_running
      super secret: "r", input: "r", valid: ['r', 'g']
    end

    it 'does not continue prompting for input' do
      after_running.assert_told_to :prompt_guess, 2
    end

    it 'does not increment my turn'
    it 'does not say it cant continue'
    it 'does not print last guess stats'
    it 'does not print invalid input message'
    it 'does not print the win message'
  end
end
