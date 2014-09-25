class MockInteract
  INTERFACE_METHODS = []

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

  INTERFACE_METHODS << def prompt_input
    messages << :prompt_input
  end

  private

  def messages
    @messages ||= []
  end
end
