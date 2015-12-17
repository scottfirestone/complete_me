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
      if current_node.children[letter].nil?
        return false
      else
        current_node = current_node.children[letter]
      end
    end
    current_node.is_word
  end

  def find_node(substring = substring.chars, node = @root)
    if substring.size == 0
      return node
    else
      if node.children.has_key?(substring[0])
        node = node.children[substring.slice!(0)]
        find_node(substring, node)
      end
    end
  end

  def find_words(node, suggestion_array = [])
    node.children.each_value do |node|
      if node.is_word
        suggestion_array <<  node.value
      end
      find_words(node, suggestion_array)
    end
    suggestion_array
  end

  def suggestions(substring)
    target_node = find_node(substring)
    find_words(target_node)
  end
  # def suggestions(substring=substring.chars, substring_slice = nil, next_node=@root, suggestions = [])
  #   if next_node.children == nil
  #     return
  #   elsif next_node.children.has_key?(substring[0])
  #     next_node = next_node.children[substring.slice!(0)]
  #     suggestions(substring(0), next_node, suggestions)
  #   end
  # end

end

if __FILE__ == $0
  trie = Dictionary.new
binding.pry
end
