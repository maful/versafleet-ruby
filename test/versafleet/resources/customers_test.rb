# frozen_string_literal: true

require "test_helper"

class CustomersResourceTest < Minitest::Test
  def test_list
    stub = stub_request("customers", response: stub_response(fixture: "customers/list"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    customers = client.customers.list

    assert_equal Versafleet::Collection, customers.class
    assert_equal Versafleet::Customer, customers.data.first.class
    assert_equal 2, customers.total
  end

  def test_retrieve
    customer_id = 1
    stub = stub_request("customers/#{customer_id}", response: stub_response(fixture: "customers/retrieve"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    customer = client.customers.retrieve(customer_id: customer_id)

    assert_equal Versafleet::Customer, customer.class
    assert_equal customer_id, customer.id
  end

  def test_create
    body = {name: "John", email: "john@example.com"}
    stub = stub_request("customers", method: :post, body: {customer: body}, response: stub_response(fixture: "customers/create"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    customer = client.customers.create(customer: body)

    assert_equal Versafleet::Customer, customer.class
    assert_equal body[:email], customer.email
  end

  def test_update
    customer_id = 3
    body = {name: "Johhny"}
    stub = stub_request("customers/#{customer_id}", method: :put, body: {customer: body}, response: stub_response(fixture: "customers/update"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    customer = client.customers.update(customer_id: customer_id, customer: body)

    assert_equal Versafleet::Customer, customer.class
    assert_equal body[:name], customer.name
  end
end
