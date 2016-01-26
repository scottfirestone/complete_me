require_relative 'node'

class Dictionary
  attr_reader :word_count, :root, :selections

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

  def suggestions(substring)
    substring_copy = substring.dup
    found_word_nodes = find_word_nodes(find_node(substring))
    suggested_words = node_words(found_word_nodes)
    if selections[substring_copy]
      suggested_words = sort_suggestions(suggested_words, substring_copy)
    end
    suggested_words
  end

  def choose(substring, selection)
    if !selections.has_key?(substring)
      selections[substring] = {selection => 1}
    else
      selections[substring][selection] += 1
    end
  end

  private

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

  def find_word_nodes(node, suggestion_node_array = [])
    suggestion_node_array << node if node.is_word
    node.children.each_value do |node|
      if node.is_word
        suggestion_node_array <<  node
      end
      find_word_nodes(node, suggestion_node_array)
    end
    suggestion_node_array.uniq
  end

  def node_words(suggestion_node_array)
    suggestion_node_array.reverse.map {|node| node.value}
  end

  def sort_suggestions(suggested, substring)
    add_zero_weights_to_non_selections(suggested, substring)
    suggested.sort_by do |word|
      -selections[substring][word]
    end
  end

  def add_zero_weights_to_non_selections(suggested, substring)
    non_selections = suggested.reject { |word| selections[substring].has_key?(word) }
    non_selections.each { |word| selections[substring][word] = 0 }
  end
end
