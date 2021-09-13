module Versafleet
  class JobsResource < Resource
    def list(**params)
      response = get_request("v2/jobs", params: params)
      Collection.from_response(response, key: "jobs", type: Job)
    end

    def create(**attributes)
      Job.new post_request("v2/jobs", body: attributes).body.dig("job")
    end

    def update(job_id:, **attributes)
      Job.new put_request("v2/jobs/#{job_id}", body: attributes).body.dig("job")
    end

    def retrieve(job_id:)
      Job.new get_request("v2/jobs/#{job_id}").body.dig("job")
    end

    def cancel(job_id:)
      Job.new put_request("v2/jobs/#{job_id}/cancel", body: {}).body
    end

    def list_tasks(job_id:)
      response = get_request("v2/jobs/#{job_id}/tasks")
      Collection.from_response(response, key: "tasks", type: Task)
    end
  end
end
