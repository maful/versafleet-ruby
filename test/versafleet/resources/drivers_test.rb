# frozen_string_literal: true

require "test_helper"

class DriversResourceTest < Minitest::Test
  def test_list
    stub = stub_request("drivers", response: stub_response(fixture: "drivers/list"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    drivers = client.drivers.list

    assert_equal Versafleet::Collection, drivers.class
    assert_equal Versafleet::Driver, drivers.data.first.class
    assert_equal 1, drivers.total
  end

  def test_retrieve
    driver_id = 123
    stub = stub_request("drivers/#{driver_id}", response: stub_response(fixture: "drivers/retrieve"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    driver = client.drivers.retrieve(driver_id: driver_id)

    assert_equal Versafleet::Driver, driver.class
    assert_equal 123, driver.id
    assert_equal "David", driver.name
  end

  def test_create
    body = {name: "Yolo Driver", dob: "1990-09-09"}
    stub = stub_request("drivers", method: :post, body: {driver: body}, response: stub_response(fixture: "drivers/create"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    driver = client.drivers.create(driver: body)

    assert_equal Versafleet::Driver, driver.class
    assert_equal "Yolo Driver", driver.name
  end

  def test_update
    driver_id = 123
    body = {name: "Yolo changed"}
    stub = stub_request("drivers/#{driver_id}", method: :put, body: {driver: body}, response: stub_response(fixture: "drivers/update"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    driver = client.drivers.update(driver_id: driver_id, driver: body)

    assert_equal Versafleet::Driver, driver.class
    assert_equal "Yolo changed", driver.name
  end
end
