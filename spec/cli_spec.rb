require 'mastermind/cli'

RSpec.describe Mastermind::CLI do
  it 'prints an intro' do
    interact = MockInteract.new
    Mastermind::CLI.call interact
    interact.assert_told_to :print_intro
  end

  it 'prints the options' do
    interact = MockInteract.new
    Mastermind::CLI.call interact
    interact.assert_told_to :print_options
  end

  it 'prompts and gets input'

  context 'when I choose to play the game' do
    it 'plays the game'
    it "doesn't print instructions"
    it "doesn't quit"
    it "doesn't print an invalid message"
    it "prompts again"
  end

  context "when I choose to see the instructions" do
    it "prints instructions"
    it "doesn't play the game"
    it "doesn't quit"
    it "doesn't print an invalid message"
    it "prompts again"
  end

  context "when I choose to see the instructions" do
    it "prints a farewell message"
    it "doesn't play the game"
    it "doesn't print instructions"
    it "doesn't print an invalid message"
    it "doesn't prompt again"
  end

  context "when my input is invalid" do
    it "prints an invalid message"
    it "doesn't print a farewell message"
    it "doesn't play the game"
    it "doesn't print instructions"
    it "prompts again"
  end
end
