require File.dirname(__FILE__) + '/test_helper'
require "active_record"
require "models/user"

class UserTest < Test::Unit::TestCase
  def test_initiaze_with_attributes
    user = User.new(:id => 1, :name => "Marc")
    assert_equal 1, user.id
    assert_equal "Marc", user.name
  end
  
  def test_find
    user = User.find(1)
    assert_equal 1, user.id
  end
  
  def test_all
    user = User.all.first
    assert_equal 1, user.id
  end
  
  def test_table_name
    assert_equal "users", User.table_name
  end
end