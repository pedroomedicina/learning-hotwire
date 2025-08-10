require "test_helper"

class Projects::TodosControllerTest < ActionDispatch::IntegrationTest
    test "add a todo inserts and scrolls to form" do
        sign_in_as users(:one)

        get new_project_todo_path(projects(:one), format: :turbo_stream)

        assert_turbo_stream action: :replace, target: :new_todo do
            assert_select "template form button", text: "Create Todo"
        end
        assert_turbo_stream action: :scroll_to, target: :new_todo
    end
end
