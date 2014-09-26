require 'mastermind'

class Mastermind
  module CLI
    module PlayGame
      def self.call(interact, secret, valid_colors)
        game  = Mastermind.new(secret, valid_colors)

        loop do
          guess = interact.prompt_guess(game)
          if !guess
            interact.print_cant_continue
            break
          elsif !game.valid_guess?(guess)
            interact.print_invalid_guess
          else
            game.guess(guess)
            if game.won?
              interact.print_win_message(game.turns_taken)
              break
            else
              interact.print_last_guess_stats(secret, guess)
            end
          end
        end
      end
    end
  end
end
