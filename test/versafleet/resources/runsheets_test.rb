# frozen_string_literal: true

require "test_helper"

class RunsheetsResourceTest < Minitest::Test
  def test_drivers_tasks
    driver_id = 1
    stub = stub_request("runsheets/drivers/#{driver_id}", response: stub_response(fixture: "runsheets/drivers_tasks"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    driver = client.runsheets.drivers_tasks(driver_id: driver_id)

    assert_equal Versafleet::Runsheet, driver.class
    assert_equal driver_id, driver.id
    assert_equal 1, driver.tasks.length
  end
end
