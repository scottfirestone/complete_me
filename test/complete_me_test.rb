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

  def test_dictionary_content
    assert @completion.dictionary.content
  end

  def test_insert_adds_to_dictionary
    @completion.insert("cat")
    assert @completion.dictionary.content.include?("cat")
  end

  def test_


end
