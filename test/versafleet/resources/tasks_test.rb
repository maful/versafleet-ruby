# frozen_string_literal: true

require "test_helper"

class TasksResourceTest < Minitest::Test
  def test_list
    stub = stub_request("tasks", response: stub_response(fixture: "tasks/list"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    tasks = client.tasks.list

    assert_equal Versafleet::Collection, tasks.class
    assert_equal Versafleet::Task, tasks.data.first.class
    assert_equal 2, tasks.total
  end

  def test_list_by_state
    stub = stub_request("tasks/by_state", response: stub_response(fixture: "tasks/list_by_state"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    tasks = client.tasks.list_by_state(state: "unassigned")

    assert_equal Versafleet::Collection, tasks.class
    assert_equal Versafleet::Task, tasks.data.first.class
    assert_equal 2, tasks.total
  end

  def test_retrieve
    task_id = 123
    stub = stub_request("tasks/#{task_id}", response: stub_response(fixture: "tasks/retrieve"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.retrieve(task_id: task_id)

    assert_equal Versafleet::Task, task.class
    assert_equal 123, task.id
  end

  def retrieve_by_tracking_id
    tracking_id = "uniq"
    stub = stub_request("tasks/#{tracking_id}/track", method: :post, response: stub_response(fixture: "tasks/track"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.retrieve_by_tracking_id(tracking_id: tracking_id)

    assert_equal Versafleet::Task, task.class
  end

  def test_update
    task_id = 123
    body = {price: 200}
    stub = stub_request("tasks/#{task_id}", method: :put, body: {task_attributes: body}, response: stub_response(fixture: "tasks/update"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.update(task_id: task_id, task_attributes: body)

    assert_equal Versafleet::Task, task.class
    assert_equal 200, task.price.to_i
  end

  def test_create
    body = read_request_body(fixture: "tasks/requests/create")
    stub = stub_request("tasks", method: :post, body: {task_attributes: body}, response: stub_response(fixture: "tasks/create"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.create(task_attributes: body)

    assert_equal Versafleet::Task, task.class
  end

  def test_assign
    task_id = 504130
    body = {driver_id: 12, vehicle_id: 13, remarks: "careful!"}
    stub = stub_request("tasks/#{task_id}/assign", method: :put, body: {task: body}, response: stub_response(fixture: "tasks/assign"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.assign(task_id: task_id, task: body)

    assert_equal Versafleet::Task, task.class
    assert_equal "assigned", task.state
  end

  def test_assign_multiple
    body = {ids: [12, 21], driver_id: 11, vehicle_id: 2, remarks: "Notes"}
    stub = stub_request("tasks/assign", method: :put, body: {task: body}, response: stub_response(fixture: "tasks/common"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    assert client.tasks.assign_multiple(task: body)
  end

  def test_unassign
    task_id = 504130
    stub = stub_request("tasks/#{task_id}/unassign", method: :put, response: stub_response(fixture: "tasks/unassign"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.unassign(task_id: task_id)

    assert_equal Versafleet::Task, task.class
    assert_equal "unassigned", task.state
  end

  def test_unassign_multiple
    body = {ids: [123, 213]}
    stub = stub_request("tasks/unassign", method: :put, body: {task: body}, response: stub_response(fixture: "tasks/common"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    assert client.tasks.unassign_multiple(task: body)
  end

  def test_cancel
    task_id = 504130
    stub = stub_request("tasks/#{task_id}/cancel", method: :put, response: stub_response(fixture: "tasks/common"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    assert client.tasks.cancel(task_id: task_id)
  end

  def test_complete
    task_id = 504130
    stub = stub_request("tasks/#{task_id}/set_successful", method: :put, response: stub_response(fixture: "tasks/common"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    assert client.tasks.complete(task_id: task_id)
  end

  def test_incomplete
    task_id = 504130
    stub = stub_request("tasks/#{task_id}/set_failed", method: :put, response: stub_response(fixture: "tasks/common"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    assert client.tasks.incomplete(task_id: task_id)
  end

  def test_set_state
    task_id = 504130
    state = "waiting_for_acknowledgement"
    stub = stub_request("tasks/#{task_id}/state", method: :put, body: {to_state: state}, response: stub_response(fixture: "tasks/common"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    assert client.tasks.set_state(task_id: task_id, to_state: state)
  end

  def test_archive
    task_id = 504130
    stub = stub_request("tasks/#{task_id}/archive", method: :put, response: stub_response(fixture: "tasks/archive"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.archive(task_id: task_id)

    assert_equal Versafleet::Task, task.class
    assert_equal true, task.archived
  end

  def test_unarchive
    task_id = 504130
    stub = stub_request("tasks/#{task_id}/unarchive", method: :put, response: stub_response(fixture: "tasks/retrieve"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.unarchive(task_id: task_id)

    assert_equal Versafleet::Task, task.class
    assert_equal false, task.archived
  end

  def test_completion_histories
    task_id = 504130
    stub = stub_request("tasks/#{task_id}/task_completion_histories", response: stub_response(fixture: "tasks/completion_histories"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.completion_histories(task_id: task_id)

    assert_equal Versafleet::Task, task.class
    assert_equal 2, task.task_completion_histories.length
  end

  def test_base_completion_histories
    task_id = 504130
    stub = stub_request("tasks/#{task_id}/base_task_completion_histories", response: stub_response(fixture: "tasks/base_completion_histories"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.base_completion_histories(task_id: task_id)

    assert_equal Versafleet::Task, task.class
    assert_equal 1, task.base_task_completion_histories.length
  end

  def test_allocate
    task_id = 504130
    sub_account_id = 200
    stub = stub_request("tasks/#{task_id}/allocate", method: :put, body: {task: {allocatee_id: sub_account_id}}, response: stub_response(fixture: "tasks/allocate"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    task = client.tasks.allocate(task_id: task_id, sub_account_id: sub_account_id)

    assert_equal Versafleet::Task, task.class
    assert_equal sub_account_id, task.account_id
  end
end
