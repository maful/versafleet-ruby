# VersaFleet API

You'll need a VersaFleet account to use the API, if you don't have one visit the [VersaFleet](https://versafleet.co) website for more information.

[![Build status](https://github.com/maful/versafleet-ruby/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/maful/versafleet-ruby/actions/workflows/test.yml) [![Gem Version](https://badge.fury.io/rb/versafleet.svg)](https://badge.fury.io/rb/versafleet)

## Installation

Add `versafleet` to your application's Gemfile:

```bash
bundle add versafleet

# OR in the Gemfile
gem "versafleet"
```

## Usage

To access the API, you'll need to create a `Versafleet::Client` and pass in your API Key and Secret Key. See [How to obtain API keys](https://versafleet.docs.apiary.io/#introduction/to-obtain-api-keys-(please-keep-them-safe!))

Need more details? See [VersaFleet API Documentation](https://rubydoc.info/gems/versafleet) to see how it works internally.

```ruby
client = Versafleet::Client.new(client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"])
```

The client then gives you access to each of resources.

## Resources

### Jobs

```ruby
# list jobs with per page is 20
client.jobs.list(per_page: 20)
# view the a job details
client.jobs.retrieve(job_id: "id")
# create a job
client.jobs.create(job: {})
# update job
client.jobs.update(job_id: "id", job: {})
# cancel the job
client.jobs.cancel(job_id: "id")
# list tasks of job
client.jobs.list_tasks(job_id: "id")
```

### Tasks

```ruby
# list all tasks
client.tasks.list
# list all tasks by state
client.tasks.list_by_state(state: state)
# get the task details
client.tasks.retrieve(task_id: task_id)
# get the task by tracking id
client.tasks.retrieve_by_tracking_id(tracking_id: tracking_id)
# update the task
client.tasks.update(task_id: task_id, task_attributes: {})
# add a task to job
client.tasks.create(task_attributes: {})
# assign task to driver
client.tasks.assign(task_id: task_id, task: {driver_id: driver_id, vehicle_id: vehicle_id, remarks: "Notes"})
# assign multiple tasks to driver
client.tasks.assign_multiple(task: {ids: [], driver_id: driver_id, vehicle_id: vehicle_id, remarks: "Notes"})
# unassign task
client.tasks.unassign(task_id: task_id)
# unassign multiple tasks
client.tasks.unassign_multiple(task: {ids: []})
# cancel the task
client.tasks.cancel(task_id: task_id)
# complete the task
client.tasks.complete(task_id: task_id)
# incomplete the task
client.tasks.incomplete(task_id: task_id)
# set state to the task
client.tasks.set_state(task_id: task_id, to_state: to_state)
# archive the task
client.tasks.archive(task_id: task_id)
# unarchive the task
client.tasks.unarchive(task_id: task_id)
# allocate task to transporter
client.tasks.allocate(task_id: task_id, sub_account_id: sub_account_id)
# get the task completion histories
client.tasks.completion_histories(task_id: task_id)
# get the base task completion histories
client.tasks.base_completion_histories(task_id: task_id)
```

### Drivers

```ruby
# list drivers
client.drivers.list
# get a driver details
client.drivers.retrieve(driver_id: driver_id)
# create driver
client.drivers.create(driver: {name: "Yolo", dob: "1990-09-09"})
# update driver
client.drivers.update(driver_id: driver_id, driver: {name: "Yolo update"})
```

### Vehicles

```ruby
# list vehicles
client.vehicles.list
# get a vehicle details
client.vehicles.retrieve(vehicle_id: vehicle_id)
# create vehicle
client.vehicles.create(vehicle: {plate_number: "SK1212", model: "Honda", speed: 50})
# update vehicle
client.vehicles.update(vehicle_id: vehicle_id, vehicle: {model: "Mercedes", speed: 70})
```

### Runsheets

```ruby
# list runsheets by driver
client.runsheets.drivers_tasks(driver_id: driver_id)
# filter runsheets by date
client.runsheets.drivers_tasks(driver_id: driver_id, date: "2021-10-14")
# filter by date and state of the tasks
client.runsheets.drivers_tasks(driver_id: driver_id, date: "2021-10-14", state: "successful")
```

### Customers

```ruby
# list customers
client.customers.list
# get a customer details
client.customers.retrieve(customer_id: customer_id)
# create customer
client.customers.create(customer: {name: "John Doe", email: "well@example.com"})
# update customer
client.customers.update(customer_id: customer_id, customer: {name: "Bourne"})
```

## TO DO

- [x] Add API Documentation ([#2](https://github.com/maful/versafleet-ruby/pull/2))
- [ ] Add Docker support
- [ ] Support to All VersaFleet API endpoints.
	- [x] Add Jobs V2 API
	- [x] Add Tasks API
	- [ ] Non-Authenticated Tracking API
	- [x] Add Runsheets API ([#5](https://github.com/maful/versafleet-ruby/pull/5))
	- [x] Add Drivers API ([#1](https://github.com/maful/versafleet-ruby/pull/1))
	- [x] Add Vehicles API ([#4](https://github.com/maful/versafleet-ruby/pull/4))
	- [x] Add Customers API ([#6](https://github.com/maful/versafleet-ruby/pull/6))
	- [ ] Add Account API

## 🙏 Contributing

This project uses Standard for formatting Ruby code. Please make sure to run standardrb before submitting pull requests. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/maful/versafleet-ruby/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the VersaFleet project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/maful/versafleet-ruby/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
