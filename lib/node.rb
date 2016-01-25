class Node
  attr_accessor :children, :is_word, :value

  def initialize(value=nil, children={})
    @value = value
    @children = children
    @is_word = false
  end
end
