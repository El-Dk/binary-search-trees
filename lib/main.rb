# frozen_string_literal: true

require './lib/tree.rb'

a = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
p a.sort
arbol = Tree.new(a)
arbol.pretty_print
puts '---------------------------'
arbol.insert(-1)
arbol.pretty_print
arbol.insert(325)
arbol.pretty_print
puts '---------------------------'
arbol.delete(324)
arbol.pretty_print
puts '---------------------------'
arbol.delete(8)
arbol.pretty_print
puts '---------------------------'
arbol.delete(4)
arbol.pretty_print

p arbol.level_order
puts '---------------------------'
p arbol.level_order_iterator
