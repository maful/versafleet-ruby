module Versafleet
  class TasksResource < Resource
    def list(**params)
      response = get_request("tasks", params: params)
      Collection.from_response(response, key: "tasks", type: Task)
    end

    def list_by_state(**params)
      response = get_request("tasks/by_state", params: params)
      Collection.from_response(response, key: "tasks", type: Task)
    end

    def retrieve(task_id:)
      Task.new get_request("tasks/#{task_id}").body.dig("task")
    end

    def retrieve_by_tracking_id(tracking_id:)
      Task.new post_request("tasks/#{tracking_id}/track", body: {}).body.dig("task")
    end

    def update(task_id:, task_attributes:)
      payload = {task_attributes: task_attributes}
      Task.new put_request("tasks/#{task_id}", body: payload).body.dig("task")
    end

    # TODO: Add support for allocate_id
    def create(task_attributes:)
      payload = {task_attributes: task_attributes}
      Task.new post_request("tasks", body: payload).body.dig("task")
    end

    def assign(task_id:, task:)
      payload = {task: task}
      Task.new put_request("tasks/#{task_id}/assign", body: payload).body.dig("task")
    end

    def assign_multiple(task:)
      payload = {task: task}
      put_request("tasks/assign", body: payload).body
    end

    def unassign(task_id:)
      Task.new put_request("tasks/#{task_id}/unassign", body: {}).body.dig("task")
    end

    def unassign_multiple(task:)
      payload = {task: task}
      put_request("tasks/unassign", body: payload).body
    end

    def cancel(task_id:)
      put_request("tasks/#{task_id}/cancel", body: {}).body
    end

    def complete(task_id:)
      put_request("tasks/#{task_id}/set_successful", body: {}).body
    end

    def incomplete(task_id:)
      put_request("tasks/#{task_id}/set_failed", body: {}).body
    end

    def set_state(task_id:, to_state:)
      payload = {to_state: to_state}
      put_request("tasks/#{task_id}/state", body: payload).body
    end

    def archive(task_id:)
      Task.new put_request("tasks/#{task_id}/archive", body: {}).body.dig("task")
    end

    def unarchive(task_id:)
      Task.new put_request("tasks/#{task_id}/unarchive", body: {}).body.dig("task")
    end

    def completion_histories(task_id:)
      Task.new get_request("tasks/#{task_id}/task_completion_histories").body
    end

    def base_completion_histories(task_id:)
      Task.new get_request("tasks/#{task_id}/base_task_completion_histories").body
    end

    def allocate(task_id:, sub_account_id:)
      payload = {task: {allocatee_id: sub_account_id}}
      Task.new put_request("tasks/#{task_id}/allocate", body: payload).body.dig("task")
    end
  end
end
