require 'test_helper'
require 'complete_me'
require 'minitest'


class CompleteMeTest<Minitest::Test

  def setup
    @completion = CompleteMe.new
  end

  def test_complete_me_instance_exists
    assert @completion.inspect
  end

  def test_dictionary_exists
    assert @completion.dictionary
  end

  # def test_insert_adds_to_dictionary
  #   @completion.insert("cat")
  #   assert @completion.dictionary.content.include?("cat")
  # end

  # def test_insert_add_two_words
  #   @completion.insert("cat")
  #   @completion.insert("dog")
  #   assert_equal ["cat", "dog"], @completion.dictionary.content
  # end

  # def test_raise_argument_if_word_in_dictionary
  #   @completion.insert("cat")
  #   assert_equal "Word is already in dictionary!", @completion.insert("cat")
  # end
  #
  # def test_new_node_created
  #
  # end
  #
  # def test_node_properties
  # end
  # #
  #
  # def test_dictionary_to_tree
  #   skip
  # end
  #

end
