require "application_system_test_case"

class MyTodosTest < ApplicationSystemTestCase
  test "infinite scroll" do
    user = users(:one)
    sign_in_as user

    todos = []
    100.times.each do |i|
      todos << {name: "Todo #{i}", user_id: user.id }
    end

    projects(:one).todos.insert_all(todos)

    visit todos_url
    assert_selector "a", text: "Todo 39", count: 1
    assert_selector "a", text: "Todo 40", count: 0

    scroll_to :bottom

    assert_selector "a", text: "Todo 40", count: 1
    assert_selector "a", text: "Todo 60", count: 0

    scroll_to :bottom

    assert_selector "a", text: "Todo 60", count: 1
    assert_selector "a", text: "Todo 80", count: 0

    scroll_to :bottom

    assert_selector "a", text: "Todo 80", count: 1
  end
end
