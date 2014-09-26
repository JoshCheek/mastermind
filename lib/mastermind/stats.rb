class Mastermind
  module Stats
    def self.correct_position(secret, guess)
      [secret.chars, guess.chars].transpose.count { |s, g| s == g }
    end


    def self.incorrect_position(secret, guess)
      remaining_secret_chars, remaining_guess_chars =
        [secret.chars, guess.chars]
          .transpose
          .reject { |s, g| s == g }
          .transpose
      remaining_guess_chars  ||= []
      remaining_secret_chars ||= []

      num_matched = 0
      remaining_guess_chars.each { |guess_char|
        if index = remaining_secret_chars.index(guess_char)
          num_matched += 1
          remaining_secret_chars.delete_at index
        end
      }
      num_matched
    end

  end
end
