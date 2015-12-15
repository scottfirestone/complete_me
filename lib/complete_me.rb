require 'dictionary'

class CompleteMe
  attr_reader :dictionary

  def initialize
    @dictionary = Dictionary.new
  end

  def insert(item)
    @dictionary.content.push(item)
  end

end
