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

  def test_insert_one_word_adds_to_dictionary
    @completion.insert("cat")
    assert @completion.dictionary.included?("cat")
  end

  def test_insert_add_two_words
    @completion.insert("cat")
    @completion.insert("dog")
    assert @completion.dictionary.included?("cat")
    assert @completion.dictionary.included?("dog")
  end

  def test_raise_argument_if_word_in_dictionary
    @completion.insert("cat")
    assert_equal "Your word is already in the dictionary!", @completion.insert("cat")
  end

  def test_suggest_returns_one_and_only_valid_value
    @completion.insert("cat")
    assert_equal ["cat"], @completion.suggest("ca")
  end

  def test_suggest_returns_two_valid_values
    @completion.insert("cat")
    @completion.insert("category")
    assert_equal ["category", "cat"], @completion.suggest("ca")
  end

  def test_suggest_returns_two_valid_values_with_three_words_in_dictionary
    @completion.insert("cat")
    @completion.insert("category")
    @completion.insert("dog")
    assert_equal ["category", "cat"], @completion.suggest("ca")
  end

  def test_dictionary_word_count_accurate
    @completion.insert("cat")
    @completion.insert("category")
    @completion.insert("dog")
    assert_equal 3, @completion.count
  end

  def test_select_method_changes_suggeston_order
    @completion.insert("category")
    @completion.insert("cat")
    assert_equal ["category", "cat"], @completion.suggest("ca")
    @completion.select("ca", "cat")
    assert_equal ["cat", "category"], @completion.suggest("ca")
  end

  def test_populate_with_dictionary_word_count
    skip
    @completion.populate(File.read("/usr/share/dict/words"))
    assert_equal 235886, @completion.count
  end
end
