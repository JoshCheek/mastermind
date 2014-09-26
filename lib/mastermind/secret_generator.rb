class Mastermind
  class SecretGenerator
    def initialize(size, valid_chars)
      self.size        = size
      self.valid_chars = valid_chars
    end

    def call
      size.times.map { valid_chars.sample }.join("")
    end

    private

    attr_accessor :size, :valid_chars
  end
end
