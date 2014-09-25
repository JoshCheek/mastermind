class Mastermind
  module CLI
    class PlayGame

    end

    def self.call(interact)
      interact.print_intro
      interact.print_options

      loop do
        input = interact.prompt_input
        if input.nil? || input == "q"
          break
        elsif input == "i"
          interact.print_instructions
        elsif input == "p"
          PlayGame.call(interact)
        else
          interact.print_invalid_message
        end
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
