require_relative 'dictionary'

class CompleteMe
  attr_reader :dictionary, :count

  def initialize
    @dictionary = Dictionary.new
  end

  def insert(word)
    if check_input_vs_dictionary(word) == false
      @dictionary.add(word)
    else
      p "Your word is already in the dictionary!"
    end
  end

  def count
    @dictionary.word_count
  end

  def check_input_vs_dictionary(input)
    @dictionary.included?(input)
  end

  def suggest(substring)
    @dictionary.suggestions(substring)
  end

  def populate(dictionary)
    new_words_array = dictionary.split(/\n/)
    new_words_array.each do |word|
      insert(word)
    end
  end

  def select(substring, selection)
    @dictionary.select(substring, selection)
  end
end
