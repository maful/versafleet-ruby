module Versafleet
  class DriversResource < Resource
    # List All Drivers
    #
    # == Examples:
    #
    #   client.drivers.list
    #   # set per page to 20
    #   client.drivers.list(per_page: 20)
    #   # move to page 2
    #   client.drivers.list(page: 2, per_page: 20)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/drivers-api/list-all-drivers VersaFleet API}
    #
    # @param params [Hash] the filter query
    # @return [Collection]
    def list(**params)
      response = get_request("drivers", params: params)
      Collection.from_response(response, key: "drivers", type: Driver)
    end

    # Get Driver details
    #
    # == Examples:
    #
    #   client.drivers.retrieve(driver_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/drivers-api/show-a-driver VersaFleet API}
    #
    # @param driver_id [Integer] Driver ID
    # @return [Driver]
    def retrieve(driver_id:)
      Driver.new get_request("drivers/#{driver_id}").body.dig("driver")
    end

    # Create a Driver
    #
    # == Examples:
    #
    #   client.drivers.create(driver: {name: "Yolo", dob: "1990-09-09"})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/drivers-api/create-a-driver VersaFleet API}
    #
    # @param driver [Hash] Driver request payload
    # @return [Driver]
    def create(driver:)
      payload = {driver: driver}
      Driver.new post_request("drivers", body: payload).body.dig("driver")
    end

    # Update Driver
    #
    # == Examples:
    #
    #   client.drivers.update(driver_id: 123, driver: {name: "John"})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/drivers-api/update-a-driver VersaFleet API}
    #
    # @param driver_id [Integer] Driver ID
    # @param driver [Hash] Driver request payload
    # @return [Driver]
    def update(driver_id:, driver:)
      payload = {driver: driver}
      Driver.new put_request("drivers/#{driver_id}", body: payload).body.dig("driver")
    end
  end
end
