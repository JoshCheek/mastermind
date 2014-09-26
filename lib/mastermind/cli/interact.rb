class Mastermind
  module CLI
    class Interact
      def initialize(stdin, stdout)
        self.stdin, self.stdout = stdin, stdout
      end

      # for CLI
      def print_intro
        stdout.puts "Welcome to Mastermind!"
      end

      def print_options
        stdout.puts 'Enter: "p" to play Mastermind'
        stdout.puts '       "i" to print mastermind instructions'
        stdout.puts '       "q" to quit'
      end

      def prompt_input
        stdout.print '> '
        input = stdin.gets
        input && input.chomp
      end

      def print_instructions
        stdout.puts "Here is how you play mastermind:.... FIXME :D"
      end

      def print_farewell
        stdout.puts "Thanks for playing, come again!"
      end

      def print_invalid_message
        stdout.puts "Your message is not valid"
      end

      # for PlayGame
      def print_cant_continue
        stdout.puts "Can't continue (no more input)"
      end

      def prompt_guess(game)
        stdout.puts "Enter your guess:"
        input = stdin.gets
        input && input.chomp
      end

      def print_last_guess_stats(secret, guess)
        stdout.puts "Colors in the correct position:   #{Stats.correct_position  secret, guess}"
        stdout.puts "Colors in the incorrect position: #{Stats.incorect_position secret, guess}"
      end

      private

      attr_accessor :stdin, :stdout
    end
  end
end
