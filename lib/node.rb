# frozen_string_literal: true

# Node class definition
class Node
  attr_accessor :left_node, :right_node, :value

  def initialize(value)
    @value = value
    @left_node = nil
    @right_node = nil
  end
end
