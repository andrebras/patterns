require File.dirname(__FILE__) + '/test_helper'
require "connection_adapter"

class ConnectionAdapterTest < Test::Unit::TestCase
  def setup
    @adapter = SqliteAdapter.new
  end
  
  def test_columns
    assert_equal [:id, :name], @adapter.columns("users")
  end
  
  def test_map_columns_to_values
    columns = [:id, :name]
    values = [1, "Marc"]
    
    # attributes = {}
    # columns.each_with_index do |column, i|
    #   attributes[column] = values[i]
    # end
    # assert_equal({:id => 1, :name => "Marc"}, attributes)
    
    assert_equal({:id => 1, :name => "Marc"}, @adapter.map_columns_to_values(columns, values))
  end
  
  def test_find
    attributes = @adapter.find(1, "users")
    assert_equal({:id => 1, :name => "Marc"}, attributes)
  end
  
  def test_find_all
    attributes = @adapter.find_all("users").first
    assert_equal({:id => 1, :name => "Marc"}, attributes)
  end
end