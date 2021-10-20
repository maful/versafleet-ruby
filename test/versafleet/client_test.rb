require "test_helper"

class ClientTest < Minitest::Test
  def test_client_id
    client = Versafleet::Client.new(client_id: "client_id", client_secret: "client_secret")
    assert_equal "client_id", client.client_id
    assert_equal "client_secret", client.client_secret
  end
end
