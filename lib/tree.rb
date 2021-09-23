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
    return nil if find(value)

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

  def include?(value, node = @root)
    return false if node.nil?

    if value > node.value
      include?(value, node.right_node)
    elsif value < node.value
      include?(value, node.left_node)
    else
      true
    end
  end

  def find(value, node = @root)
    return nil if node.nil?

    if value > node.value
      find(value, node.right_node)
    elsif value < node.value
      find(value, node.left_node)
    else
      node
    end
  end

  def level_order(values_array = [], node = @root, array = [])
    return nil if node.nil?

    values_array << node.value
    i = 0
    unless node.left_node.nil?
      array << node.left_node
      i += 1
    end
    unless node.right_node.nil?
      array << node.right_node
      i += 1
    end
    i.times { level_order(values_array, array.shift, array) }
    values_array
  end

  def level_order_iterator
    return nil if @root.nil?

    node_array = [@root]
    values_array = []
    node_array.each do |node|
      values_array << node.value
      node_array << node.left_node unless node.left_node.nil?
      node_array << node.right_node unless node.right_node.nil?
    end
    values_array
  end

  def inorder(values_array = [], node = @root)
    return nil if node.nil?

    inorder(values_array, node.left_node)
    values_array << node.value
    inorder(values_array, node.right_node)
    values_array
  end

  def preorder(values_array = [], node = @root)
    return nil if node.nil?

    values_array << node.value
    preorder(values_array, node.left_node)
    preorder(values_array, node.right_node)
    values_array
  end

  def postorder(values_array = [], node = @root)
    return nil if node.nil?

    postorder(values_array, node.left_node)
    postorder(values_array, node.right_node)
    values_array << node.value
    values_array
  end

  def height(node = @root, current_height = 0, heights = [])
    return 0 if node.nil?

    heights << current_height if node.left_node.nil? && node.right_node.nil?
    current_height += 1
    height(node.left_node, current_height, heights)
    height(node.right_node, current_height, heights)
    heights.max
  end

  def depth(node, current_node = @root, depth = 0)
    return 0 if current_node.nil?

    if node.value < current_node.value
      depth += 1
      depth(node, current_node.left_node, depth)
    elsif node.value > current_node.value
      depth += 1
      depth(node, current_node.right_node, depth)
    else
      depth
    end
  end

  def balanced?(node = @root)
    return nil if @root.nil?

    return true if node.nil?

    balanced = balanced?(node.left_node) && balanced?(node.right_node)
    balanced = false if (height(node.left_node) - height(node.right_node)).abs > 1
    balanced
  end

  def rebalance
    return nil if @root.nil? || balanced?

    values_array = level_order.uniq.sort
    @root = build_tree(values_array, 0, values_array.length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end
