module Versafleet
  class CustomersResource < Resource
    # List All Customers
    #
    # == Examples:
    #
    #   client.customers.list
    #   # set per page to 20
    #   client.customers.list(per_page: 20)
    #   # move to page 2
    #   client.customers.list(page: 2, per_page: 20)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/customer-api/list-all-customers VersaFleet API}
    #
    # @param params [Hash] the filter query
    # @return [Collection]
    def list(**params)
      response = get_request("customers", params: params)
      Collection.from_response(response, key: "customers", type: Customer)
    end

    # Get Customer details
    #
    # == Example:
    #
    #   client.customers.retrieve(customer_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/customer-api/show-a-customer-detail VersaFleet API}
    #
    # @param customer_id [Integer|String] Customer ID or Customer GUID
    # @return [Customer]
    def retrieve(customer_id:)
      Customer.new get_request("customers/#{customer_id}").body.dig("customer")
    end

    # Create a Customer
    #
    # == Example:
    #
    #   client.customers.create(customer: {name: "John Doe", email: "well@example.com"})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/customer-api/create-a-customer-detail VersaFleet API}
    #
    # @param customer [Hash] Customer request payload
    # @return [Customer]
    def create(customer:)
      payload = {customer: customer}
      Customer.new post_request("customers", body: payload).body.dig("customer")
    end

    # Update Customer
    #
    # == Example:
    #
    #   client.customers.update(customer_id: 123, customer: {name: "Bourne"})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/customer-api/update-a-customer-detail VersaFleet API}
    #
    # @param customer_id [Integer|String] Customer ID or Customer GUID
    # @param customer [Hash] Customer request payload
    # @return [Customer]
    def update(customer_id:, customer:)
      payload = {customer: customer}
      Customer.new put_request("customers/#{customer_id}", body: payload).body.dig("customer")
    end
  end
end
