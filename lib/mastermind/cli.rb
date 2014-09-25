class Mastermind
  module CLI
    def self.call(interact)
      interact.print_intro
      interact.print_options
      input = interact.prompt_input
      # print an intro
      # print the options
      # prompt and get your option
      # loop {
      #   "p" -> play game
      #   "i" -> print mastermind instructions
      #   "q" -> quit
      #   invalid input -> tell you to try again
      # }
    end
  end
end
