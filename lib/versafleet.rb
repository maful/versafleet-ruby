require "faraday"
require "faraday_middleware"
require "versafleet/version"

module Versafleet
  autoload :Client, "versafleet/client"
  autoload :Resource, "versafleet/resource"
  autoload :Object, "versafleet/object"
  autoload :Error, "versafleet/error"
  autoload :Collection, "versafleet/collection"

  # Resources (like high level API endpoints)
  autoload :JobsResource, "versafleet/resources/jobs"
  autoload :TasksResource, "versafleet/resources/tasks"
  autoload :DriversResource, "versafleet/resources/drivers"
  autoload :VehiclesResource, "versafleet/resources/vehicles"

  # Classes used to return a nicer object wrapping the response data
  autoload :Job, "versafleet/objects/job"
  autoload :Task, "versafleet/objects/task"
  autoload :Driver, "versafleet/objects/driver"
  autoload :Vehicle, "versafleet/objects/vehicle"
end
