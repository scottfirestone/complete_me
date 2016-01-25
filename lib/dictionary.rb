require_relative 'node'

class Dictionary
  attr_reader :word_count, :root
  attr_accessor :selections

  def initialize
    @root = Node.new
    @word_count = 0
    @selections = {}
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

  def find_node(substring, node = @root)
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
    new_string = substring.dup
    suggestion_node_array = find_words(find_node(substring))
    suggested = sorted_node_method(suggestion_node_array)
    if selections[new_string]
      suggested = sort_suggestions(suggested, new_string)
    end
    suggested
  end

  def sort_suggestions(suggested, substring)
    add_to_hash = suggested.reject do |word|
      selections[substring].has_key?(word)
    end
    add_to_hash.each do |word|
      selections[substring][word] = 0
    end
    suggested.sort_by do |word|
      -selections[substring][word]
    end
  end

  def sorted_node_method(suggestion_node_array)
    suggestion_node_array.reverse.map {|node| node.value}
  end

  def choose(substring, selection)
    if !selections.has_key?(substring)
      selections[substring] = {selection => 1}
    else
      selections[substring][selection] += 1
    end

  end
end
