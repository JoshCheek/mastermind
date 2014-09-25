require 'spec_helper'
require 'mastermind/cli/interact'

RSpec.describe Mastermind::CLI::Interact do
  it 'implements all the Interact interface methods' do
    MockInteract::INTERFACE_METHODS.each do |interface_method_name|
      expect(Mastermind::CLI::Interact.instance_methods).to include interface_method_name
    end
  end
end
