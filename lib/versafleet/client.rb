module Versafleet
  class Client
    BASE_URL = "https://api.versafleet.co/api"

    attr_reader :client_id, :client_secret

    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
    end

    def jobs
      JobsResource.new(self)
    end

    def tasks
      TasksResource.new(self)
    end

    def drivers
      DriversResource.new(self)
    end

    def connection
      @connection ||= Faraday.new(params: default_params) do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter Faraday.default_adapter
      end
    end

    private

    def default_params
      {client_id: client_id, client_secret: client_secret}
    end
  end
end
