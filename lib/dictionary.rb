require 'pry'
require_relative 'node'

class Dictionary
  attr_reader :word_count, :root

  def initialize
    @root = Node.new
    @word_count = 0
  end

  def add(word)
    current = @root
    current.value = ""
    word.chars.each do |letter|
      if current.children.has_key?(letter)
        current = current.children[letter]
      else
        current.children[letter] = Node.new(current.value)
        current = current.children[letter]
        current.value += letter
      end
    end
    current.is_word = true
    @word_count+=1
  end

  def included?(word, current_node=@root)
    word.chars.each do |letter|
      if current_node.children[letter] == nil
        return false
      else
        current_node = current_node.children[letter]
      end
    end
    current_node.is_word
  end


  def suggest(substring, current_node=@root, suggestions = [])
    if current_node.children.has_key?(substring.slice(0))
      current_node = current_node.children[word.slice!(0)]
      current.suggest(word, current_node, suggestions)
    end
  end

end

binding.pry
