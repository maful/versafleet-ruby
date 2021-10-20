require "test_helper"

class ObjectTest < Minitest::Test
  def test_creating_object_from_hash
    assert_equal "bar", Versafleet::Object.new(foo: "bar").foo
  end

  def test_nested_number
    assert_equal 123, Versafleet::Object.new(task: {base_task: {id: 123}}).task.base_task.id
  end

  def test_nested_hash
    assert_equal "Homecoming", Versafleet::Object.new(task: {address: {name: "Homecoming"}}).task.address.name
  end

  def test_array
    object = Versafleet::Object.new(task: [{id: 123}])
    assert_equal OpenStruct, object.task.first.class
    assert_equal 123, object.task.first.id
  end
end
