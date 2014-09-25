class Mastermind
  module CLI
    class Interact
      def initialize(stdin, stdout)
        self.stdin, self.stdout = stdin, stdout
      end

      def print_intro
        stdout.puts "Welcome to Mastermind!"
      end

      private

      attr_accessor :stdin, :stdout
    end
  end
end
