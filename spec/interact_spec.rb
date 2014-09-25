require 'spec_helper'
require 'mastermind/cli/interact'
require 'stringio'

RSpec.describe Mastermind::CLI::Interact do
  it 'implements all the Interact interface methods' do
    MockInteract::INTERFACE_METHODS.each do |interface_method_name|
      expect(Mastermind::CLI::Interact.instance_methods).to include interface_method_name
    end
  end

  def assert_prints_something(message, stdin="")
    stdin        = StringIO.new stdin
    stdout       = StringIO.new
    interact     = Mastermind::CLI::Interact.new(stdin, stdout)
    return_value = interact.__send__ message
    expect(stdout.string).to_not be_empty
    return_value
  end

  it 'prints the intro' do
    assert_prints_something :print_intro
  end

  it 'prints the options' do
    assert_prints_something :print_options
  end

  describe "prompt_input" do
    it "prompts the input and returns the user's selection" do
      returned = assert_prints_something :prompt_input, "a\nb\nc\n"
      expect(returned).to eq "a"
    end

    it "returns nil when the stream is empty" do
      returned = assert_prints_something :prompt_input, ""
      expect(returned).to eq nil
    end
  end
end
