# frozen_string_literal: true

# Node
class Node
  attr_accessor :location, :parent, :children

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

  attr_accessor :queue

  def initialize(start)
    @root = Node.new(start, nil)
    @queue = [@root]
    @path = []
  end

  def possible_moves(node)
    TRANSFORMS.each do |transform|
      move_x = node.location[0] + transform[0]
      move_y = node.location[1] + transform[1]
      next unless move_x.between?(0, 7) && move_y.between?(0, 7)

      move_node = Node.new([move_x, move_y], node)
      # puts "[#{move_x}, #{move_y}]"
      node.children.push(move_node)
      queue.push(move_node)
    end
  end

  def path_of_travail(node)
    until node.nil?
      @path.unshift("#{node.location} ")
      node = node.parent
    end
  end

  def print_path
    move_count = @path.length - 1
    move_plural = move_count == 1 ? 'move' : 'moves'
    puts "\nYou made it in #{move_count} #{move_plural}! Here's your path:"
    puts @path << "\n"
  end
end

def knight_moves(start, finish)
  knight = Knight.new(start)
  node = knight.queue.shift
  until node.location == finish
    knight.possible_moves(node)
    node = knight.queue.shift
  end
  knight.path_of_travail(node)
  knight.print_path
end

knight_moves([0, 0], [1, 2])
knight_moves([3, 3], [4, 3])
knight_moves([7, 0], [0, 7])
