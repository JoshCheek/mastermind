require 'spec_helper'
require 'mastermind/cli/interact'
require 'stringio'

RSpec.describe Mastermind::CLI::Interact do
  it 'implements all the Interact interface methods' do
    MockInteract::INTERFACE_METHODS.each do |interface_method_name|
      expect(Mastermind::CLI::Interact.instance_methods).to include interface_method_name
    end
  end

  it 'prints the intro' do
    stdin = StringIO.new
    stdout = StringIO.new
    interact = Mastermind::CLI::Interact.new(stdin, stdout)
    interact.print_intro
    expect(stdout.string).to_not be_empty
  end

  it 'prints the options' do
    stdin = StringIO.new
    stdout = StringIO.new
    interact = Mastermind::CLI::Interact.new(stdin, stdout)
    interact.print_options
    expect(stdout.string).to_not be_empty
  end
end
