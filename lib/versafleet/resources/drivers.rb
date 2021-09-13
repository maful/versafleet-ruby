module Versafleet
  class DriversResource < Resource
    def list(**params)
      response = get_request("drivers", params: params)
      Collection.from_response(response, key: "drivers", type: Driver)
    end

    def retrieve(driver_id:)
      Driver.new get_request("drivers/#{driver_id}").body.dig("driver")
    end

    def create(driver:)
      payload = {driver: driver}
      Driver.new post_request("drivers", body: payload).body.dig("driver")
    end

    def update(driver_id:, driver:)
      payload = {driver: driver}
      Driver.new put_request("drivers/#{driver_id}", body: payload).body.dig("driver")
    end
  end
end
