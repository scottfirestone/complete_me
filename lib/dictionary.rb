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

  def find_node(substring, node = @root)
    if substring.size == 0
      return node
    else
      if node.children.has_key?(substring[0])
        node = node.children[substring[0]]
        find_node(substring[1..-1], node)
      end
    end
  end

  def find_words(node)
    current = node.is_word ? [node] : []
    current + node.children.values.flat_map { |child| find_words(child) }
  end

  def suggestions(substring)
    target_node = find_node(substring)
    find_words(target_node).
      sort_by(&:weight).
      reverse.map(&:value)
  end

  def select(substring, selection)
    found_node = find_node(selection)
    found_node.weight += 1
  end
end
