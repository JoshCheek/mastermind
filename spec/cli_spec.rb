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

  context 'when I choose to play the game' do
    it 'plays the game'
    it "doesn't print instructions"
    it "doesn't quit"
    xit "doesn't print an invalid message" do
      after_running("p").refute_told_to :print_invalid_message
    end

    it "prompts again"
  end

  context "when I choose to see the instructions" do
    it "prints instructions" do
      after_running("").refute_told_to :print_instructions
      after_running("i").assert_told_to :print_instructions
    end

    it "doesn't play the game"
    it "doesn't quit"

    it "doesn't print an invalid message" do
      after_running("i").refute_told_to :print_invalid_message
    end

    it "prompts again"
  end

  context "when I choose to quit" do
    it "prints a farewell message" do
      after_running("q").assert_told_to :print_farewell
    end

    it "doesn't play the game"

    it "doesn't print instructions" do
      after_running("q").refute_told_to :print_instructions
    end

    it "doesn't print an invalid message" do
      after_running("q").refute_told_to :print_invalid_message
    end

    it "doesn't prompt again"
  end

  context "when my input is invalid" do
    let(:invalid_message) { "sdlkfj" }

    it "prints an invalid message" do
      after_running(invalid_message).assert_told_to :print_invalid_message
    end

    it "doesn't print a farewell message"
    it "doesn't play the game"
    it "doesn't print instructions" do
      after_running(invalid_message).refute_told_to :print_instructions
    end
    it "prompts again"
  end
end
