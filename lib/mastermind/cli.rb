class Mastermind
  module CLI
    def self.call(interact)
      interact.print_intro
      interact.print_options
      input = interact.prompt_input
      if input == "i"
        interact.print_instructions
      end

      # loop {
      #   "p" -> play game
      #   "q" -> quit
      #   invalid input -> tell you to try again
      # }
      interact.print_farewell
    end
  end
end
