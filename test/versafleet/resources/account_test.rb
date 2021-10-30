# frozen_string_literal: true

require "test_helper"

class AccountResourceTest < Minitest::Test
  def test_retrieve
    account_id = 1
    stub = stub_request("billing_accounts/#{account_id}", response: stub_response(fixture: "account/retrieve"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    account = client.account.retrieve(account_id: account_id)

    assert_equal Versafleet::Account, account.class
    assert_equal account_id, account.id
  end

  def test_create
    customer_id = 1
    body = {name: "Danny", email: "danny@example.com"}
    stub = stub_request("billing_accounts/#{customer_id}", method: :post, body: {billing_account: body}, response: stub_response(fixture: "account/create"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    account = client.account.create(customer_id: customer_id, account: body)

    assert_equal Versafleet::Account, account.class
    assert_equal body[:name], account.name
    assert_equal body[:email], account.email
  end

  def test_update
    account_id = 1
    body = {name: "Nany"}
    stub = stub_request("billing_accounts/#{account_id}", method: :put, body: {billing_account: body}, response: stub_response(fixture: "account/update"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    account = client.account.update(account_id: account_id, account: body)

    assert_equal Versafleet::Account, account.class
    assert_equal body[:name], account.name
  end

  def test_delete
    account_id = 1
    stub = stub_request("billing_accounts/#{account_id}", method: :delete, response: stub_response(fixture: "account/delete"))
    client = Versafleet::Client.new(client_id: "fake", client_secret: "fake", adapter: :test, stubs: stub)
    response = client.account.delete(account_id: account_id)

    assert_equal response["message"].first, "success"
  end
end
