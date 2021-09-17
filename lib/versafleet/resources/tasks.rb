module Versafleet
  class TasksResource < Resource
    # List All Tasks
    #
    # == Examples:
    #
    #   client.tasks.list
    #   # set per page to 20
    #   client.tasks.list(per_page: 20)
    #   # set specific date
    #   client.tasks.list(date: "2021-01-01")
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/list-all-tasks VersaFleet API}
    #
    # @param params [Hash] the filter query
    # @return [Collection]
    def list(**params)
      response = get_request("tasks", params: params)
      Collection.from_response(response, key: "tasks", type: Task)
    end

    # List All Tasks by State
    #
    # == Examples:
    #
    #   client.tasks.list_by_state
    #   # tasks by state
    #   client.tasks.list_by_state(state: "completed")
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/list-all-tasks-by-state VersaFleet API}
    #
    # @param params [Hash] the filter query
    # @return [Collection]
    def list_by_state(**params)
      response = get_request("tasks/by_state", params: params)
      Collection.from_response(response, key: "tasks", type: Task)
    end

    # Get Task details
    #
    # == Examples:
    #
    #   client.tasks.retrieve(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/view-details-of-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @return [Task]
    def retrieve(task_id:)
      Task.new get_request("tasks/#{task_id}").body.dig("task")
    end

    # Get Task details by Tracking ID
    #
    # == Examples:
    #
    #   client.tasks.retrieve_by_tracking_id(tracking_id: "1234567891100")
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/view-limited-task-details-from-tracking-id VersaFleet API}
    #
    # @param tracking_id [String] Tracking ID
    # @return [Task]
    def retrieve_by_tracking_id(tracking_id:)
      Task.new post_request("tasks/#{tracking_id}/track", body: {}).body.dig("task")
    end

    # Update Task
    #
    # == Examples:
    #
    #   client.tasks.update(task_id: 123, task_attributes: {})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/update-a-task-detail VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @param task_attributes [Hash] Task request payload
    # @return [Task]
    def update(task_id:, task_attributes:)
      payload = {task_attributes: task_attributes}
      Task.new put_request("tasks/#{task_id}", body: payload).body.dig("task")
    end

    # Add Task to Job
    #
    # == Examples:
    #
    #   client.tasks.create(task_attributes: {})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/add-a-new-task-to-a-job VersaFleet API}
    #
    # @param task_attributes [Hash] Task request payload
    # @return [Task]
    def create(task_attributes:)
      # TODO: Add support for allocate_id
      payload = {task_attributes: task_attributes}
      Task.new post_request("tasks", body: payload).body.dig("task")
    end

    # Assign a Driver to Task
    #
    # == Examples:
    #
    #   client.tasks.assign(task_id: 123, task: {driver_id: 12, vehicle_id: 3, remarks: "Notes"})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/assign-a-driver-to-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @param task [Hash] Driver and Vehicle details
    # @return [Task]
    def assign(task_id:, task:)
      payload = {task: task}
      Task.new put_request("tasks/#{task_id}/assign", body: payload).body.dig("task")
    end

    # Assign a Driver to Multiple Tasks
    #
    # == Examples:
    #
    #   client.tasks.assign_multiple(task: {ids: [12,21], driver_id: 11, vehicle_id: 2, remarks: "Notes"})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/assign-a-driver-to-multiple-tasks VersaFleet API}
    #
    # @param task [Hash] Task IDs, Driver and Vehicle details
    def assign_multiple(task:)
      payload = {task: task}
      put_request("tasks/assign", body: payload).body
    end

    # Unssign a Driver from Task
    #
    # == Examples:
    #
    #   client.tasks.unassign(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/unassign-a-driver-from-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @return [Task]
    def unassign(task_id:)
      Task.new put_request("tasks/#{task_id}/unassign", body: {}).body.dig("task")
    end

    # Unsssign a Driver from Multiple Tasks
    #
    # == Examples:
    #
    #   client.tasks.unassign_multiple(task: {ids: [123,213]})
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/unassign-a-driver-from-multiple-tasks VersaFleet API}
    #
    # @param task [Hash] Task IDs
    def unassign_multiple(task:)
      payload = {task: task}
      put_request("tasks/unassign", body: payload).body
    end

    # Cancel a Task
    #
    # == Examples:
    #
    #   client.tasks.cancel(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/cancel-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    def cancel(task_id:)
      put_request("tasks/#{task_id}/cancel", body: {}).body
    end

    # Complete a Task
    #
    # == Examples:
    #
    #   client.tasks.complete(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/complete-/-succeed-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    def complete(task_id:)
      put_request("tasks/#{task_id}/set_successful", body: {}).body
    end

    # Incomplete a Task
    #
    # == Examples:
    #
    #   client.tasks.incomplete(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/incomplete-/-fail-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    def incomplete(task_id:)
      put_request("tasks/#{task_id}/set_failed", body: {}).body
    end

    # Set a Task State
    #
    # == Examples:
    #
    #   client.tasks.set_state(task_id: 123, to_state: "waiting_for_acknowledgement")
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/set-a-task-state VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @param to_state [String] Task state
    def set_state(task_id:, to_state:)
      payload = {to_state: to_state}
      put_request("tasks/#{task_id}/state", body: payload).body
    end

    # Archive a Task
    #
    # == Examples:
    #
    #   client.tasks.archive(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/archive-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @return [Task]
    def archive(task_id:)
      Task.new put_request("tasks/#{task_id}/archive", body: {}).body.dig("task")
    end

    # Unarchive a Task
    #
    # == Examples:
    #
    #   client.tasks.unarchive(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/unarchive-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @return [Task]
    def unarchive(task_id:)
      Task.new put_request("tasks/#{task_id}/unarchive", body: {}).body.dig("task")
    end

    # View Task Completion Histories of a Task
    #
    # == Examples:
    #
    #   client.tasks.completion_histories(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/view-task-completion-histories-of-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @return [Task]
    def completion_histories(task_id:)
      Task.new get_request("tasks/#{task_id}/task_completion_histories").body
    end

    # View Base Task Completion Histories of a Task
    #
    # == Examples:
    #
    #   client.tasks.base_completion_histories(task_id: 123)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/view-base-task-completion-histories-of-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @return [Task]
    def base_completion_histories(task_id:)
      Task.new get_request("tasks/#{task_id}/base_task_completion_histories").body
    end

    # Allocate a Task
    #
    # == Examples:
    #
    #   client.tasks.allocate(task_id: 123, sub_account_id: 211)
    #
    # {https://versafleet.docs.apiary.io/#reference/0/tasks-api/allocate-a-task VersaFleet API}
    #
    # @param task_id [Integer] Task ID
    # @param sub_account_id [Integer] Transporter ID
    # @return [Task]
    def allocate(task_id:, sub_account_id:)
      payload = {task: {allocatee_id: sub_account_id}}
      Task.new put_request("tasks/#{task_id}/allocate", body: payload).body.dig("task")
    end
  end
end
