module Versafleet
  class VehiclesResource < Resource
    # List All Vehicles
    #
    # == Examples:
    #
    #   client.vehicles.list
    #   # set per page to 20
    #   client.vehicles.list(per_page: 20)
    #   # move to page 2
    #   client.vehicles.list(page: 2, per_page: 20)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/vehicles-api/list-all-vehicles VersaFleet API}
    #
    # @param params [Hash] the filter query
    # @return [Collection]
    def list(**params)
      response = get_request("vehicles", params: params)
      Collection.from_response(response, key: "vehicles", type: Vehicle)
    end

    # Get Vehicle details
    #
    # == Examples:
    #
    #   client.vehicles.retrieve(vehicle_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/vehicles-api/show-a-vehicle VersaFleet API}
    #
    # @param vehicle_id [Integer] Vehicle ID
    # @return [Vehicle]
    def retrieve(vehicle_id:)
      Vehicle.new get_request("vehicles/#{vehicle_id}").body.dig("vehicle")
    end

    # Create a Vehicle
    #
    # == Examples:
    #
    #   client.vehicles.create(vehicle: {plate_number: "SK1212", model: "Honda", speed: 50})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/vehicles-api/create-a-vehicle VersaFleet API}
    #
    # @param vehicle [Hash] Vehicle request payload
    # @return [Vehicle]
    def create(vehicle:)
      payload = {vehicle: vehicle}
      Vehicle.new post_request("vehicles", body: payload).body.dig("vehicle")
    end

    # Update Vehicle
    #
    # == Examples:
    #
    #   client.vehicles.update(vehicle_id: 123, vehicle: {model: "Mercedes", speed: 70})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/vehicles-api/update-a-vehicle VersaFleet API}
    #
    # @param vehicle_id [Integer] Vehicle ID
    # @param vehicle [Hash] Vehicle request payload
    # @return [Vehicle]
    def update(vehicle_id:, vehicle:)
      payload = {vehicle: vehicle}
      Vehicle.new put_request("vehicles/#{vehicle_id}", body: payload).body.dig("vehicle")
    end
  end
end
