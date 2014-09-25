class MockInteract
  INTERFACE_METHODS = []

  def initialize(*stdin_results)
    self.stdin_results = stdin_results
  end

  def assert_told_to(expected_message)
    return if messages.include? expected_message
    raise "Was not told to #{expected_message.inspect}, was only told to #{messages.inspect}"
  end

  INTERFACE_METHODS << def print_intro
    messages << :print_intro
  end

  INTERFACE_METHODS << def print_options
    messages << :print_options
  end

  INTERFACE_METHODS << def print_instructions
    messages << :print_instructions
  end

  INTERFACE_METHODS << def prompt_input
    messages << :prompt_input
    stdin_results.shift
  end

  private

  attr_accessor :stdin_results

  def messages
    @messages ||= []
  end
end
