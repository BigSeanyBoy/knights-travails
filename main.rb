# frozen_string_literal: true

# Node
class Node
  attr_accessor :location, :children

  def initialize(location, parent)
    @location = location
    @parent = parent
    @children = []
  end
end

# Knight
class Knight
  TRANSFORMS = [
    [-2, 1], [-1, 2], [1, 2], [2, 1],
    [2, -1], [1, -2], [-1, -2], [-2, -1]
  ].freeze

  def initialize(start)
    @root = Node.new(start, nil)
    @queue = []
  end

  def possible_moves(node = @root)
    TRANSFORMS.each do |transform|
      move_x = node.location[0] + transform[0]
      move_y = node.location[1] + transform[1]
      next if move_x.between?(0, 7) && move_y.between?(0, 7)

      move_node = Node.new([move_x, move_y], node)
      node.children.push(move_node)
      queue.push(move_node)
    end
  end
end
