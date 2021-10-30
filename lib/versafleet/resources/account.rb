module Versafleet
  class AccountResource < Resource
    # Get Account details
    #
    # == Example:
    #
    #   client.account.retrieve(account_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/account-api/view-a-account VersaFleet API}
    #
    # @param account_id [Integer|String] Account ID or Account GUID
    # @return [Account]
    def retrieve(account_id:)
      Account.new get_request("billing_accounts/#{account_id}").body.dig("billing_account")
    end

    # Create an Account
    #
    # == Example:
    #
    #   client.account.create(customer_id: 123, account: {name: "Johhny", email: "john@example.com"})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/account-api/create-account VersaFleet API}
    #
    # @param customer_id [Integer] Customer ID
    # @param account [Hash] Account request payload
    # @return [Account]
    def create(customer_id:, account:)
      payload = {billing_account: account}
      Account.new post_request("billing_accounts/#{customer_id}", body: payload).body.dig("billing_account")
    end

    # Update an Account
    #
    # == Example:
    #
    #   client.account.update(account_id: 123, account: {name: "Johhny"})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/account-api VersaFleet API}
    #
    # @param account_id [Integer] Account ID
    # @param account [Hash] Account request payload
    # @return [Account]
    def update(account_id:, account:)
      payload = {billing_account: account}
      Account.new put_request("billing_accounts/#{account_id}", body: payload).body.dig("billing_account")
    end

    # Delete an Account
    #
    # == Example:
    #
    #   client.account.delete(account_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/account-api/delete-an-account VersaFleet API}
    #
    # @param account_id [Integer] Account ID
    def delete(account_id:)
      delete_request("billing_accounts/#{account_id}").body
    end
  end
end
