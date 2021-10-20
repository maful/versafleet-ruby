$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "versafleet"
require "minitest/autorun"
require "faraday"
require "json"

class Minitest::Test
  def stub_response(fixture:, status: 200, headers: {"Content-Type" => "application/json"})
    [status, headers, File.read("test/fixtures/#{fixture}.json")]
  end

  def stub_request(path, response:, method: :get, body: {})
    Faraday::Adapter::Test::Stubs.new do |stub|
      arguments = [method, "/api/#{path}"]
      arguments << body.to_json if [:post, :put].include?(method)
      stub.send(*arguments) { |env| response }
    end
  end

  def read_request_body(fixture:)
    file = File.read("test/fixtures/#{fixture}.json")
    JSON.parse(file)
  end
end
