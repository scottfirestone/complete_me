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
      "Word is already in dictionary!"
    end

    def count
      
    end

  end

  # def check_input_vs_dictionary(input)
  #   input = input.downcase
  #   @dictionary.content.include?(input)
  # end
end
