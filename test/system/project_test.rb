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

    test "drag and drop" do
        project = projects(:one)
        project.todos.delete_all
        todo1 = project.todos.create!(name: "Todo 1")
        todo2 = project.todos.create!(name: "Todo 2")
        todo3 = project.todos.create!(name: "Todo 3")

        assert_equal 1, todo1.position
        assert_equal 2, todo2.position
        assert_equal 3, todo3.position

        sign_in_as users(:one)
        visit project_url(project)

        todo1_element = find("div[id=#{dom_id(todo1)}]")
        todo2_element = find("div[id=#{dom_id(todo2)}]")
        todo3_element = find("div[id=#{dom_id(todo3)}]")

        todo1_element.drag_to(todo3_element)

        assert_equal 2, todo3.reload.position
        assert_equal 3, todo1.reload.position
    end
end