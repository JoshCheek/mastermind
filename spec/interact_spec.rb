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



  context 'PlayGame methods' do
    it 'prints a cant continue message' do
      assert_prints_something :print_cant_continue
    end

    describe "prompt_guess" do
      let(:mock_game) { Object.new }

      it "prompts the input and returns the user's selection" do
        returned = assert_prints_something :prompt_guess, stdin: "a\nb\nc\n", args: [mock_game]
        expect(returned).to eq "a"
      end

      it "returns nil when the stream is empty" do
        returned = assert_prints_something :prompt_guess, stdin: "", args: [mock_game]
        expect(returned).to eq nil
      end

      # should take a game
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
  end
end
