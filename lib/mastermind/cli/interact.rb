class Mastermind
  module CLI
    class Interact
      def initialize(stdin, stdout)
        self.stdin, self.stdout = stdin, stdout
      end

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

      private

      attr_accessor :stdin, :stdout
    end
  end
end
