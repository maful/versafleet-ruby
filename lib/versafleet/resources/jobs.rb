module Versafleet
  class JobsResource < Resource
    # List All Jobs
    #
    # == Examples:
    #
    #   client.jobs.list
    #   # set per page to 20
    #   client.jobs.list(per_page: 20)
    #   # move to page 2
    #   client.jobs.list(page: 2, per_page: 20)
    #   # filter by Customer ID
    #   client.jobs.list(customer_id: 1231)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/jobs-v2-api/list-all-jobs VersaFleet API}
    #
    # @param params [Hash] the filter query
    # @return [Collection]
    def list(**params)
      response = get_request("v2/jobs", params: params)
      Collection.from_response(response, key: "jobs", type: Job)
    end

    # Create a Job
    #
    # == Examples:
    #
    #   # see the VersaFleet API for the request body reference
    #   client.jobs.create(job: {})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/jobs-v2-api/create-a-new-job VersaFleet API}
    #
    # @param attributes [Hash] Request body
    # @return [Job]
    def create(**attributes)
      Job.new post_request("v2/jobs", body: attributes).body.dig("job")
    end

    # Update Job
    #
    # == Examples:
    #
    #   # see the VersaFleet API for the request body reference
    #   client.jobs.update(job_id: 123, job: {})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/jobs-v2-api/update-job-or-base-task-details VersaFleet API}
    #
    # @param job_id [Integer] Job ID
    # @param attributes [Hash] Request body
    # @return [Job]
    def update(job_id:, **attributes)
      Job.new put_request("v2/jobs/#{job_id}", body: attributes).body.dig("job")
    end

    # Get Job details
    #
    # == Examples:
    #
    #   client.jobs.retrieve(job_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/jobs-v2-api/view-details-of-a-job VersaFleet API}
    #
    # @param job_id [Integer] Job ID
    # @return [Job]
    def retrieve(job_id:)
      Job.new get_request("v2/jobs/#{job_id}").body.dig("job")
    end

    # Cancel a Job
    #
    # == Examples:
    #
    #   client.jobs.cancel(job_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/jobs-v2-api/cancel-a-job VersaFleet API}
    #
    # @param job_id [Integer] Job ID
    def cancel(job_id:)
      put_request("v2/jobs/#{job_id}/cancel", body: {}).body
    end

    # List Tasks of Job
    #
    # == Examples:
    #
    #   client.jobs.list_tasks(job_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/jobs-v2-api/list-tasks-of-job VersaFleet API}
    #
    # @param job_id [Integer] Job ID
    # @return [Collection]
    def list_tasks(job_id:)
      response = get_request("v2/jobs/#{job_id}/tasks")
      Collection.from_response(response, key: "tasks", type: Task)
    end
  end
end
