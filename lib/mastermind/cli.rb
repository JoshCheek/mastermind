require 'mastermind/cli/play_game'

class Mastermind
  module CLI
    def self.call(interact, secret_generator, valid_colors)
      interact.print_intro
      interact.print_options
      loop do
        input = interact.prompt_input
        if    input.nil?   then break
        elsif input == "q" then break
        elsif input == "i" then interact.print_instructions
        elsif input == "p" then PlayGame.call(interact, secret_generator.call, valid_colors)
        else                    interact.print_invalid_message
        end
      end
      interact.print_farewell
    end
  end
end
