require 'test_helper'
require 'minitest'
require 'dictionary'

class DictionaryTest < Minitest::Test
  attr_reader :dictionary

  def setup
    @dictionary = Dictionary.new
  end

  def test_dictionary_instance
    assert dictionary
  end

  def test_it_has_root
    assert dictionary.root
  end

  def test_root_instance_defaults_to_node_instance
    assert_equal Node, dictionary.root.class
  end

  def test_root_empty_children_hash_by_default
    assert_equal ({}), dictionary.root.children
  end

  def test_add_word
    dictionary.add("pizza")
    assert_equal "pizza", dictionary.root.children["p"].children["i"].children["z"].children["z"].children["a"].value
  end

  def test_included_function_returns_true
    dictionary.add("pizza")
    assert dictionary.included?("pizza")
  end

  def test_dictionary_word_count_returns_0_by_default
    assert_equal 0, dictionary.word_count
  end

  def test_dictionary_word_count_returns_1_for_1_value
    dictionary.add("pizza")
    assert_equal 1, dictionary.word_count
  end

  def test_dictionary_word_count_returns_2_for_2_values
    dictionary.add("pizza")
    dictionary.add("pie")
    assert_equal 2, dictionary.word_count
  end

  def test_suggestion_array_returns_four_words
    dictionary.add("pizza")
    dictionary.add("pie")
    dictionary.add("pizzaria")
    dictionary.add("pizzarias")
    assert_equal ["pie", "pizzarias", "pizzaria", "pizza"], dictionary.suggestions("pi")
  end

  def test_has_selections_hash
    assert dictionary.selections
    assert Hash, dictionary.selections.class
  end

  def test_choose_method_alters_selections_hash_for_new_choice
    expected = {}
    assert_equal expected, dictionary.selections
    dictionary.choose("pi", "pizza")
    expected = {"pi" => {"pizza" => 1}}
    assert_equal expected, dictionary.selections
  end

  def test_choose_method_alters_selections_hash_to_add_weight_to_existing
    expected = {}
    assert_equal expected, dictionary.selections
    dictionary.choose("pi", "pizza")
    expected = {"pi" => {"pizza" => 1}}
    assert_equal expected, dictionary.selections
    dictionary.choose("pi", "pizza")
    expected = {"pi" => {"pizza" => 2}}
    assert_equal expected, dictionary.selections
  end

  def test_suggestions_alters_array_if_selection_exists
    dictionary.add("pizza")
    dictionary.add("pie")
    dictionary.choose("pi", "pizza")
    assert_equal ({"pi" => {"pizza" => 1}}), dictionary.selections
    assert_equal ["pizza", "pie"], dictionary.suggestions("pi")
  end
end
