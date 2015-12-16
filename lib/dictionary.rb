require 'pry'
require_relative 'node'

class Dictionary
  attr_reader :word_count, :root

  def initialize
    @root = Node.new
    @word_count = 0
  end

  # def word_count
  #   @word_count = @content.size
  #   @word_count
  # end

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

  def suggest(substring)
  end

end

binding.pry
