class Mastermind
  def initialize(secret, valid_colors)
  end


  module CLI
    module PlayGame
      def self.call(interact, secret, valid_colors)
        game  = Mastermind.new(secret, valid_colors)

        loop do
          guess = interact.prompt_guess
          break unless guess
          # if !game.valid_guess?(guess)
          # end
        end


        # create the game
        # loop
        #   display the turn
        #   guess = prompt for the guess
        #   if guess is invalid
        #     print invalid message
        #     do not increment turn
        #   if guess is incorrect
        #     print stats
        #     do increment turn
        #   if guess is correct
        #     print win message
        #     break
      end
    end
  end
end

# (secret rrgb)

# You are on turn 1
# Enter a guess ("r", "g", "b", "y")
# > rrbr
# Colors in the correct position: 2
# Colors in the incorrect position: 1

# You are on turn 2
# Enter a guess ("r", "g", "b", "y")
# > rzbr
# Invalid input!

# You are on turn 2
# Enter a guess ("r", "g", "b", "y")
# > rrgb
# Correct you won in 2 turns!
