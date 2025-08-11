require "application_system_test_case"

class ProjectTest < ApplicationSystemTestCase
    test "adding a todo to a project" do
        sign_in_as users(:one)
        visit project_url(projects(:one))
        click_link "Add a todo"
        fill_in "Name", with: "New example todo"
        click_button "Create Todo"
        assert_selector "a", text: "New example todo"
        assert_field "Name", with: ""
    end
end