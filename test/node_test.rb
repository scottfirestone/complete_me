require 'test_helper'
require 'node'

class NodeTest < Minitest::Test
  attr_reader :node

  def setup
    @node = Node.new
  end

  def test_node_instance
    assert node
  end

  def test_node_value_defaults_to_nil
    assert_equal nil, node.value
  end

  def test_node_link_children_property_exists_with_default_empty_hash
    assert_equal ({}), node.children
  end

  def test_node_is_word_default_to_false
    assert_equal false, node.is_word
  end

end
