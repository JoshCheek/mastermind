class Mastermind
  module CLI
    class PlayGame

    end

    def self.call(interact)
      interact.print_intro
      interact.print_options
      loop do
        input = interact.prompt_input
        if    input.nil?   then break
        elsif input == "q" then break
        elsif input == "i" then interact.print_instructions
        elsif input == "p" then PlayGame.call(interact)
        else                    interact.print_invalid_message
        end
      end
      interact.print_farewell
    end
  end
end
