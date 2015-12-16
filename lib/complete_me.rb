require_relative 'dictionary'
require 'pry'

class CompleteMe
  attr_reader :dictionary

  def initialize
    @dictionary = Dictionary.new
  end

  def insert(word)
    if check_input_vs_dictionary(word) == false
      @dictionary.add(word)
    else
      "Your word is already in the dictionary!"
    end
  end

  def check_input_vs_dictionary(input)
    @dictionary.included?(input.downcase)
  end

  def suggest(substring)
    @dictionary.suggestions(substring)
  end

  def select
  end
end
