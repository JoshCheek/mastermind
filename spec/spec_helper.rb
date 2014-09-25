class MockInteract
  INTERFACE_METHODS = []

  def assert_told_to(expected_message)
    return if messages.include? expected_message
    raise "Was not told to #{expected_message.inspect}, was only told to #{messages.inspect}"
  end

  INTERFACE_METHODS << def print_intro
    messages << :print_intro
  end

  private

  def messages
    @messages ||= []
  end
end
