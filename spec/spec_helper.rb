class MockInteract
  INTERFACE_METHODS = []

  def self.define_interface_method(method_name, &additional_body)
    INTERFACE_METHODS << method_name
    define_method(method_name) do
      messages << method_name
      additional_body && instance_eval(&additional_body)
    end
  end

  define_interface_method(:print_intro)
  define_interface_method(:print_options)
  define_interface_method(:print_farewell)
  define_interface_method(:print_instructions)
  define_interface_method(:print_invalid_message)
  define_interface_method(:prompt_input) { stdin_results.shift }

  def initialize(*stdin_results)
    self.stdin_results = stdin_results
  end

  def refute_told_to(message)
    return unless messages.include? message
    raise "Was told to #{message.inspect}, but should not have been!"
  end

  def assert_told_to(expected_message, num_times=nil)
    if !num_times
      return if messages.include? expected_message
      raise "Was not told to #{expected_message.inspect}, was only told to #{messages.inspect}"
    else
      actual_times = messages.count { |message| message == expected_message }
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
