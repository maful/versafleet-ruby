module Versafleet
  class RunsheetsResource < Resource
    # View Driver Info and related Tasks
    #
    # == Examples:
    #
    #   client.runsheets.drivers_tasks(driver_id: 1)
    #   # filter runsheets by date
    #   client.runsheets.drivers_tasks(driver_id: 1, date: "2021-10-14")
    #   # filter by date and state of the tasks
    #   client.runsheets.drivers_tasks(driver_id: 1, date: "2021-10-14", state: "successful")
    #
    # {https://versafleet.docs.apiary.io/#reference/0/runsheet-api/view-driver-info-and-related-tasks VersaFleet API}
    #
    # @param driver_id [Integer] Driver ID
    # @param params [Hash] the filter query
    # @return [Runsheet]
    def drivers_tasks(driver_id:, **params)
      Runsheet.new get_request("runsheets/drivers/#{driver_id}", params: params).body.dig("driver")
    end
  end
end
