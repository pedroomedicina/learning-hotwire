require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "my todos infinite scroll frame" do
    user = users(:one)
    sign_in_as user

    todos = []
    40.times do |i|
      todos << {name: "Todo #{i}", user_id: user.id}
    end

    projects(:one).todos.insert_all(todos)

    get todos_path, headers: { "Turbo-Frame" => "x" }
    assert_select "turbo-frame[id=todos_page_1][target=_top]" do
      assert_select "turbo-frame[id=todos_page_2][target=_top][loading=lazy][src='/todos?page=2']"
    end

    get todos_path(page: 2), headers: { "Turbo-Frame" => "x" }
    assert_select "turbo-frame[id=todos_page_2][target=_top]" do
      assert_select "turbo-frame[id=todos_page_3][target=_top][loading=lazy]", count: 0
    end
  end
end
