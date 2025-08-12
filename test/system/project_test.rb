require "application_system_test_case"

class ProjectTest < ApplicationSystemTestCase
    include ActiveJob::TestHelper
    
    test "adding a todo to a project" do
        sign_in_as users(:one)
        visit project_url(projects(:one))
        click_link "Add a todo"
        fill_in "Name", with: "New example todo"
        click_button "Create Todo"
        assert_selector "a", text: "New example todo"
        assert_field "Name", with: ""
    end

    test "refreshes the project when a new todo is broadcast" do
        project = projects(:one)
        sign_in_as users(:one)
        visit project_url(project)
        assert_turbo_cable_stream_source project, visible: :all
        assert_selector "a", text: "New example todo", count: 0
        project.todos.create!(name: "New example todo")
        perform_enqueued_jobs
        assert_selector "a", text: "New example todo", count: 1
    end
end