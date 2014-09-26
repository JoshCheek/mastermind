class MockSecretGenerator
  attr_accessor :secret
  def initialize
    self.secret = 'default secret'
  end
  alias call secret
end

class MockInteract
  INTERFACE_METHODS = []

  def self.define_interface_method(method_name, &additional_body)
    INTERFACE_METHODS << method_name
    define_method(method_name) do |*args|
      messages << [method_name, args]
      additional_body && instance_eval(&additional_body)
    end
  end

  # for CLI
  define_interface_method(:print_intro)
  define_interface_method(:print_options)
  define_interface_method(:print_farewell)
  define_interface_method(:print_instructions)
  define_interface_method(:print_invalid_message)
  define_interface_method(:prompt_input) { stdin_results.shift }

  # for CLI::PlayGame
  define_interface_method(:print_win_message)
  define_interface_method(:print_invalid_guess)
  define_interface_method(:print_cant_continue)
  define_interface_method(:print_last_guess_stats)
  define_interface_method(:prompt_guess) { stdin_results.shift }

  def initialize(*stdin_results)
    self.stdin_results = stdin_results
  end

  # TODO: rename messages to invocations
  def refute_told_to(message)
    return unless messages.map(&:first).include? message
    raise "Was told to #{message.inspect}, but should not have been!"
  end

  def assert_told_to(expected_message, options={})
    num_times = options[:num_times]
    with      = options[:with] || -> * { true }
    if !num_times
      return if messages.any? { |message, args| message == expected_message && with.call(*args) }
      raise "Was not told to #{expected_message.inspect}, was only told to #{messages.inspect}"
    else
      # NOTE: does not respect :with
      actual_times = messages.count { |message, args| message == expected_message }
      return if actual_times == num_times
      raise "Expected to be be told to #{expected_message.inspect} #{num_times} times, but got #{actual_times} times"
    end
  end

  private

  attr_accessor :stdin_results

  def messages
    @messages ||= []
  end
end
