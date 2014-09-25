require 'mastermind/cli'

RSpec.describe Mastermind::CLI do
  def after_running(input="")
    interact = MockInteract.new(input)
    Mastermind::CLI.call interact
    interact
  end

  it 'prints an intro' do
    after_running.assert_told_to :print_intro
  end

  it 'prints the options' do
    after_running.assert_told_to :print_options
  end

  it 'prompts and gets input' do
    after_running.assert_told_to :prompt_input
  end

  it 'quits when there is no more input' do
    after_running(nil).assert_told_to :prompt_input, 1
    after_running(nil).assert_told_to :print_farewell
  end

  context 'when I choose to play the game' do
    let(:message) { 'p' }
    before do
      allow(Mastermind::CLI::PlayGame).to receive(:call)
    end

    it 'plays the game' do
      expect(Mastermind::CLI::PlayGame).to receive(:call).with(an_instance_of MockInteract)
      after_running(message)
    end

    it "doesn't print instructions" do
      after_running(message).refute_told_to :print_instructions
    end

    it "doesn't print an invalid message" do
      after_running(message).refute_told_to :print_invalid_message
    end

    it "prompts again" do
      after_running(message).assert_told_to :prompt_input, 2
    end
  end

  context "when I choose to see the instructions" do
    let(:message) { 'i' }

    it "prints instructions" do
      after_running("").refute_told_to :print_instructions
      after_running(message).assert_told_to :print_instructions
    end

    it "doesn't play the game" do
      expect(Mastermind::CLI::PlayGame).to_not receive(:call)
      after_running(message)
    end

    it "doesn't print an invalid message" do
      after_running(message).refute_told_to :print_invalid_message
    end

    it "prompts again" do
      after_running(message).assert_told_to :prompt_input, 2
    end
  end

  context "when I choose to quit" do
    let(:message) { "q" }

    it "prints a farewell message" do
      after_running(message).assert_told_to :print_farewell
    end

    it "doesn't play the game" do
      expect(Mastermind::CLI::PlayGame).to_not receive(:call)
      after_running(message)
    end

    it "doesn't print instructions" do
      after_running(message).refute_told_to :print_instructions
    end

    it "doesn't print an invalid message" do
      after_running(message).refute_told_to :print_invalid_message
    end

    it "doesn't prompt again" do
      after_running(message).assert_told_to :prompt_input, 1
    end
  end

  context "when my input is invalid" do
    let(:message) { "sdlkfj" }

    it "prints an invalid message" do
      after_running(message).assert_told_to :print_invalid_message
    end

    it "doesn't play the game" do
      expect(Mastermind::CLI::PlayGame).to_not receive(:call)
      after_running(message)
    end

    it "doesn't print instructions" do
      after_running(message).refute_told_to :print_instructions
    end

    it "prompts again" do
      after_running(message).assert_told_to :prompt_input, 2
    end
  end
end
