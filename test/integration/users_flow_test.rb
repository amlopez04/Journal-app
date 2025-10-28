require "test_helper"

# NOTE: UsersFlowTest disabled - Devise handles user authentication
# Manual user CRUD routes have been removed in favor of Devise
class UsersFlowTest < ActionDispatch::IntegrationTest
  # test "create a user" do
  #   assert_difference("User.count", 1) do
  #     post users_path, params: { user: { name: "Alice", email: "alice@example.com", password: "secret" } }
  #   end
  #   follow_redirect!
  #   assert_response :success
  #   assert_select "h1", "Alice"
  # end

  # test "edit a user" do
  #   user = User.create!(name: "Bob", email: "bob@example.com", password: "secret")
  #   patch user_path(user), params: { user: { name: "Bobby" } }
  #   follow_redirect!
  #   assert_select "h1", "Bobby"
  # end

  # test "show a user" do
  #   user = User.create!(name: "Charlie", email: "charlie@example.com", password: "secret")
  #   get user_path(user)
  #   assert_response :success
  #   assert_select "h1", "Charlie"
  # end

  # test "index users" do
  #   User.create!(name: "Daisy", email: "daisy@example.com", password: "secret")
  #   get users_path
  #   assert_response :success
  #   assert_select "h1", "Users"
  #   assert_select "li", /Daisy/
  # end
end
