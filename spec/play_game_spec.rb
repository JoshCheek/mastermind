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

    it 'does not continue prompting for a guess' do
      after_running.assert_told_to :prompt_guess, num_times: 1
      after_running.assert_told_to :prompt_guess, with: -> game { game.turns_taken == 0 }
    end

    it 'exits the game with a cant continue message' do
      after_running.assert_told_to :print_cant_continue
    end

    it 'does not print last guess stats' do
      after_running.refute_told_to :print_last_guess_stats
    end

    it 'does not print invalid input message' do
      after_running.refute_told_to :print_invalid_guess
    end

    it 'does not print the win message'
  end

  context 'when my guess is invalid' do
    def after_running
      super input: "z", valid: ['r']
    end

    it 'prints that the input was invalid' do
      after_running.assert_told_to :print_invalid_guess
    end

    it 'continues prompting for input' do
      after_running.assert_told_to :prompt_guess, num_times: 2
    end

    it 'does not increment my turn'

    it 'does not print last guess stats' do
      after_running.refute_told_to :print_last_guess_stats
    end

    it 'does not print the win message'
  end

  context 'when my guess is incorrect' do
    let(:secret) { 'g' }
    let(:guess)  { 'r' }
    def after_running
      super secret: secret, input: guess, valid: ['r', 'g']
    end

    it 'continues prompting for input' do
      after_running.assert_told_to :prompt_guess, num_times: 2
    end

    it 'increments my turn' do
      after_running.assert_told_to :prompt_guess, num_times: 2
      after_running.assert_told_to :prompt_guess, with: -> game { game.turns_taken == 1 }
    end

    it 'prints last guess stats' do
      after_running.assert_told_to :print_last_guess_stats, with: -> s, g { s == secret && g == guess }
    end

    it 'does not print invalid input message' do
      after_running.refute_told_to :print_invalid_guess
    end

    it 'does not print the win message'
  end

  context 'when my guess is correct' do
    def after_running
      super secret: "r", input: "r", valid: ['r', 'g']
    end

    it 'prints the win message' do
      after_running.assert_told_to :print_win_message, with: -> num_guesses { num_guesses == 1 }
    end

    it 'does not continue prompting for input' do
      after_running.assert_told_to :prompt_guess, num_times: 2
    end

    it 'does not increment my turn'
    it 'does not print last guess stats'

    it 'does not print invalid input message' do
      after_running.refute_told_to :print_invalid_guess
    end

    it 'does not print the win message'
  end
end
