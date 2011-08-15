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
    
    attributes = {}
    columns.each_with_index do |column, i|
      attributes[column] = values[i]
    end
    assert_equal({:id => 1, :name => "Marc"}, attributes)
    
    ### using nice Ruby API
    
    # p columns.zip(values)
    # p Hash[:id, 1]
    attributes = Hash[columns.zip(values)]
    
    assert_equal({:id => 1, :name => "Marc"}, attributes)
    
    ### refactor to connection_adapter.rb
    
    attributes = @adapter.map_columns_to_values(columns, values)
    
    assert_equal({:id => 1, :name => "Marc"}, attributes)
  end
  
  def test_find
    attributes = @adapter.find(1, "users")
    assert_equal 1, attributes[:id]
  end
  
  def test_find_all
    attributes = @adapter.find_all("users").first
    assert_equal 1, attributes[:id]
  end
end