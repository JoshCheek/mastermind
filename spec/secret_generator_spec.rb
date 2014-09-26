require 'mastermind/secret_generator'

RSpec.describe Mastermind::SecretGenerator do
  it 'returns a string of the specified length' do
    gen2 = Mastermind::SecretGenerator.new(2, ['a', 'b', 'c'])
    gen3 = Mastermind::SecretGenerator.new(3, ['a', 'b', 'c'])
    10_000.times do
      expect(gen2.call.size).to eq 2
      expect(gen3.call.size).to eq 3
    end
  end

  it 'each character is from the valid chars' do
    chars_seen = ""
    gen = Mastermind::SecretGenerator.new(5, ['a', 'b', 'c'])
    1000.times { chars_seen << gen.call }
    expect(chars_seen.chars.uniq.sort).to eq ['a', 'b', 'c']
  end

  it 'returns random results' do
    secrets_seen = []
    gen = Mastermind::SecretGenerator.new(5, ['a', 'b', 'c'])
    10.times { secrets_seen << gen.call }
    expect(secrets_seen.uniq.size).to be > 1
  end
end
