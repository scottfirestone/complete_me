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

  def find_words(node, suggestion_node_array = [])
    suggestion_node_array << node if node.is_word
    node.children.each_value do |node|
      if node.is_word
        suggestion_node_array <<  node
      end
      find_words(node, suggestion_node_array)
    end
    suggestion_node_array.uniq
  end

  def suggestions(substring)
    target_node = find_node(substring)
    suggestion_node_array = find_words(target_node)
    sorted_node_array = suggestion_node_array.sort_by{ |node| node.weight}.reverse
    sorted_node_array.map {|node| node.value}
  end

  def select(substring, selection)
    found_node = find_node(selection)
    found_node.weight += 1
  end

end

if __FILE__ == $0
  trie = Dictionary.new
  trie.add("poop")
end
