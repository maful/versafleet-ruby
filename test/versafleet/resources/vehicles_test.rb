# frozen_string_literal: true

require "test_helper"

class VehiclesResourceTest < Minitest::Test
  def test_list
    stub = stub_request("vehicles", response: stub_response(fixture: "vehicles/list"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    vehicles = client.vehicles.list

    assert_equal Versafleet::Collection, vehicles.class
    assert_equal Versafleet::Vehicle, vehicles.data.first.class
    assert_equal 2, vehicles.total
  end

  def test_retrieve
    vehicle_id = 1
    stub = stub_request("vehicles/#{vehicle_id}", response: stub_response(fixture: "vehicles/retrieve"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    vehicle = client.vehicles.retrieve(vehicle_id: vehicle_id)

    assert_equal Versafleet::Vehicle, vehicle.class
    assert_equal vehicle_id, vehicle.id
  end

  def test_create
    body = {plate_number: "KJ111", model: "Honda", speed: 100}
    stub = stub_request("vehicles", method: :post, body: {vehicle: body}, response: stub_response(fixture: "vehicles/create"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    vehicle = client.vehicles.create(vehicle: body)

    assert_equal Versafleet::Vehicle, vehicle.class
    assert_equal body[:plate_number], vehicle.plate_number
  end

  def test_update
    vehicle_id = 3
    body = {speed: 40}
    stub = stub_request("vehicles/#{vehicle_id}", method: :put, body: {vehicle: body}, response: stub_response(fixture: "vehicles/update"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    vehicle = client.vehicles.update(vehicle_id: vehicle_id, vehicle: body)

    assert_equal Versafleet::Vehicle, vehicle.class
    assert_equal body[:speed], vehicle.speed
  end
end
