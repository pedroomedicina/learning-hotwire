require "test_helper"

class TodoTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "create broadcasts" do
    project = projects(:one)
    user = users(:one)

    project.todos.create!(name: "example", user:)

    assert_enqueued_jobs 2
    perform_enqueued_jobs

    assert_turbo_stream_broadcasts project, count: 1
    assert_turbo_stream_broadcasts user, count: 1
  end
end
