module Versafleet
  class Client
    # Default API endpoint
    BASE_URL = "https://api.versafleet.co/api"

    # @return [String] Gets the VersaFleet API Key
    attr_reader :client_id

    # @return [String] Gets the VersaFleet Secret Key
    attr_reader :client_secret

    # Initialize a new VersaFlet client
    #
    # == Example:
    #
    #   client = Versafleet::Client.new(client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"])
    #   # use Jobs resource
    #   client.jobs.list
    #
    # @param client_id [String] VersaFleet API Key
    # @param client_secret [String] VersaFleet Secret Key
    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
    end

    # Jobs Resource instance
    #
    # @return [JobsResource]
    def jobs
      JobsResource.new(self)
    end

    # Tasks Resource instance
    #
    # @return [TasksResource]
    def tasks
      TasksResource.new(self)
    end

    # Drivers Resource instance
    #
    # @return [DriversResource]
    def drivers
      DriversResource.new(self)
    end

    # Initializes a new Faraday connection
    #
    # @return [Faraday::Connection]
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
