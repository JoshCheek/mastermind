class Mastermind
  module Stats
    def self.correct_position(secret, guess)
      [secret.chars, guess.chars].transpose.count { |s, g| s == g }
    end


    def self.incorrect_position(secret, guess)
      remaining_secret_chars, remaining_guess_chars =
        [secret.chars, guess.chars].transpose.reject { |s, g| s == g }.transpose
      return 0 unless remaining_secret_chars

      remaining_guess_chars.count { |guess_char|
        next unless index = remaining_secret_chars.index(guess_char)
        remaining_secret_chars.delete_at index
      }
    end
  end
end
