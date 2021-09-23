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

  def insert(value, node = @root)
    new_node = Node.new(value)
    if @root.nil?
      @root = new_node
      return new_node
    end

    return new_node if node.nil?

    if value < node.value
      node.left_node = insert(value, node.left_node)
    elsif value > node.value
      node.right_node = insert(value, node.right_node)
    else
      return new_node
    end
    node
  end

  def delete(value, node = (first_call = true
                            @root))
    return nil if @root.nil?

    return @root = delete(value, @root) if first_call

    if value > node.value
      node.right_node = delete(value, node.right_node)
      node
    elsif value < node.value
      node.left_node = delete(value, node.left_node)
      node
    else
      return nil if node.left_node.nil? && node.right_node.nil?
      return node.left_node if node.right_node.nil?
      return node.right_node if node.left_node.nil?

      new_node = smallest_node(node.right_node)
      new_node.right_node = delete(new_node.value, node.right_node)
      new_node.left_node = node.left_node
      new_node
    end
  end

  def smallest_node(node)
    return node if node.left_node.nil?

    smallest_node(node.left_node)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end
