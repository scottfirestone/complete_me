require_relative 'dictionary'

class CompleteMe
  attr_reader :dictionary, :count

  def initialize
    @dictionary = Dictionary.new
  end

  def insert(word)
    if check_input_vs_dictionary(word) == false
      dictionary.add(word)
    else
      "#{word.capitalize} is already in the dictionary!"
    end
  end

  def count
    dictionary.word_count
  end

  def check_input_vs_dictionary(input)
    dictionary.included?(input)
  end

  def suggest(substring)
    dictionary.suggestions(substring)
  end

  def populate(word_library)
    word_library.split(/\n/).each { |word| insert(word) }
  end

  def select(substring, selection)
    dictionary.choose(substring, selection)
  end
end
