# frozen_string_literal: true

require './lib/tree'

# Create a binary search tree from an array of random numbers
random_array = (Array.new(15) { rand(1..100) })
p random_array

# Confirm that the tree is balanced by calling #balanced?
bst = Tree.new(random_array)
bst.pretty_print
print 'Tree balanced? '
p bst.balanced?

# Print out all elements in level, pre, post, and in order
print 'Preorder: '
p bst.preorder
print 'Inorder: '
p bst.inorder
print 'Postorder: '
p bst.postorder

# Unbalance the tree by adding several numbers > 100
rand(3..5).times { bst.insert(rand(1..100)) }
bst.pretty_print

# Confirm that the tree is unbalanced by calling #balanced?
print 'Modified tree balanced? '
p bst.balanced?

# Balance the tree by calling #rebalance
bst.rebalance
bst.pretty_print

# Confirm that the tree is balanced by calling #balanced?
print 'Tree rebalanced? '
p bst.balanced?

# Print out all elements in level, pre, post, and in order
print 'Lever order: '
p bst.level_order
print 'Preorder: '
p bst.preorder
print 'Inorder: '
p bst.inorder
print 'Postorder: '
p bst.postorder
