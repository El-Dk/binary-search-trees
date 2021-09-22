# frozen_string_literal: true

require './lib/node'

# Tree class definition
class Tree
  def initialize(array)
    cleaned_array = array.uniq.sort
    @root = build_tree(cleaned_array, 0, cleaned_array.length - 1)
  end

  def build_tree(array, min, max)
    return nil if min > max

    mid = (max + min) / 2
    node = Node.new(array[mid])
    node.left_node = build_tree(array, min, mid - 1)
    node.right_node = build_tree(array, mid + 1, max)
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end
