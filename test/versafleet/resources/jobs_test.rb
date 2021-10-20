# frozen_string_literal: true

require "test_helper"

class JobsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("v2/jobs", response: stub_response(fixture: "jobs/list"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    jobs = client.jobs.list

    assert_equal Versafleet::Collection, jobs.class
    assert_equal Versafleet::Job, jobs.data.first.class
    assert_equal 2, jobs.total
  end

  def test_retrieve
    job_id = 12
    stub = stub_request("v2/jobs/#{job_id}", response: stub_response(fixture: "jobs/retrieve"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    job = client.jobs.retrieve(job_id: job_id)

    assert_equal Versafleet::Job, job.class
    assert_equal 12, job.id
  end

  def test_create
    body = read_request_body(fixture: "jobs/requests/create")
    stub = stub_request("v2/jobs", method: :post, body: {job: body}, response: stub_response(fixture: "jobs/create"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    job = client.jobs.create(job: body)

    assert_equal Versafleet::Job, job.class
  end

  def test_update
    job_id = 123
    body = {remarks: "Update remarks"}
    stub = stub_request("v2/jobs/#{job_id}", method: :put, body: {job: body}, response: stub_response(fixture: "jobs/update"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    job = client.jobs.update(job_id: job_id, job: body)

    assert_equal Versafleet::Job, job.class
    assert_equal "Update remarks", job.remarks
  end

  def test_cancel
    job_id = 123
    stub = stub_request("v2/jobs/#{job_id}/cancel", method: :put, response: stub_response(fixture: "jobs/cancel"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    assert client.jobs.cancel(job_id: job_id)
  end

  def test_list_tasks
    job_id = 123
    stub = stub_request("v2/jobs/#{job_id}/tasks", response: stub_response(fixture: "jobs/list_tasks"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    tasks = client.jobs.list_tasks(job_id: job_id)

    assert_equal Versafleet::Collection, tasks.class
    assert_equal Versafleet::Task, tasks.data.first.class
    assert_equal 1, tasks.total
  end
end
