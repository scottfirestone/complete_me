require 'test_helper'
require 'minitest'
require 'dictionary'

class DictionaryTest < Minitest::Test

  def setup
    @dictionary = Dictionary.new
  end

  def test_dictionary_instance
    assert @dictionary
  end

  def test_root_instance
    assert @dictionary.root
  end

  def test_root_empty_children_hash_by_default
    assert_equal ({}), @dictionary.root.children
  end

  def test_add_word
    @dictionary.add("pizza")
    assert_equal "pizza", @dictionary.root.children["p"].children["i"].children["z"].children["z"].children["a"].value
  end

  # def test_add_two
  # def test_dictionary_word_count_returns_0_by_default
  #   assert_equal 0, @dictionary.word_count
  # end
  #
  # def test_dictionary_word_count_returns_2_for_2_values
  #   @dictionary.content = ["cat", "dog"]
  #   assert_equal 2, @dictionary.word_count
  # end


end
