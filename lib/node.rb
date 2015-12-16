class Node
  attr_accessor :children, :is_word, :weight, :value

  def initialize(value=nil, children={})
    @value = value
    @children = children
    @is_word = false
    @weight = 0
  end
end
