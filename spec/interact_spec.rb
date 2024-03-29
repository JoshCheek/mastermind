require 'spec_helper'
require 'mastermind/cli/interact'
require 'stringio'

RSpec.describe Mastermind::CLI::Interact do
  it 'implements all the Interact interface methods' do
    MockInteract::INTERFACE_METHODS.each do |interface_method_name|
      expect(Mastermind::CLI::Interact.instance_methods).to include interface_method_name
    end
  end

  def assert_prints_something(message, options={})
    args         = options.fetch(:args, [])
    stdin        = StringIO.new options.fetch(:stdin, "")
    stdout       = StringIO.new
    interact     = Mastermind::CLI::Interact.new(stdin, stdout)
    return_value = interact.__send__ message, *args
    expect(stdout.string).to_not be_empty
    return_value
  end

  context 'CLI methods' do
    it 'prints the intro' do
      assert_prints_something :print_intro
    end

    it 'prints the options' do
      assert_prints_something :print_options
    end

    it 'prints the instructions' do
      assert_prints_something :print_instructions
    end

    it 'prints the farewell message' do
      assert_prints_something :print_farewell
    end

    it 'prints an invalid message' do
      assert_prints_something :print_invalid_message
    end

    describe "prompt_input" do
      it "prompts the input and returns the user's selection" do
        returned = assert_prints_something :prompt_input, stdin: "a\nb\nc\n"
        expect(returned).to eq "a"
      end

      it "returns nil when the stream is empty" do
        returned = assert_prints_something :prompt_input, stdin: ""
        expect(returned).to eq nil
      end
    end
  end



  context 'PlayGame methods' do
    it 'prints a cant continue message' do
      assert_prints_something :print_cant_continue
    end

    describe "prompt_guess" do
      let(:valid_colors) { ['a', 'b', 'c'] }
      let(:mock_game)    { Mastermind.new("r", valid_colors) }

      it 'prints the current turn, and the valid inputs' do
        stdout   = StringIO.new
        interact = Mastermind::CLI::Interact.new(StringIO.new, stdout)
        interact.prompt_guess(mock_game)
        expect(stdout.string).to include '"a"'
        expect(stdout.string).to include '"b"'
        expect(stdout.string).to include '"c"'
        expect(stdout.string).to include "turn 1"
      end

      it "prompts the input and returns the user's selection" do
        returned = assert_prints_something :prompt_guess, stdin: "a\nb\nc\n", args: [mock_game]
        expect(returned).to eq "a"
      end

      it "returns nil when the stream is empty" do
        returned = assert_prints_something :prompt_guess, stdin: "", args: [mock_game]
        expect(returned).to eq nil
      end
    end

    it 'prints the last guess\'s stats' do
      stdout   = StringIO.new
      interact = Mastermind::CLI::Interact.new(nil, stdout)
      interact.print_last_guess_stats "rrrg", "grry"
      expect(stdout.string).to match /\bcorrect position:\s*2\b/
      expect(stdout.string).to match /\bincorrect position:\s*1\b/
    end

    it 'prints that a guess was invalid' do
      assert_prints_something :print_invalid_guess
    end

    it 'prints the win message' do
      stdout   = StringIO.new
      interact = Mastermind::CLI::Interact.new(nil, stdout)
      interact.print_win_message 2
      expect(stdout.string).to match /\b2\b/
      expect(stdout.string).to_not match /\b3\b/

      stdout   = StringIO.new
      interact = Mastermind::CLI::Interact.new(nil, stdout)
      interact.print_win_message 3
      expect(stdout.string).to match /\b3\b/
      expect(stdout.string).to_not match /\b2\b/
    end
  end
end
