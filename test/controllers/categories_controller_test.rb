require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: "test@example.com", 
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "should get new" do
    sign_in @user, scope: :user
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    sign_in @user, scope: :user
    assert_difference("Category.count") do
      post categories_url, params: { category: { name: "Test Category" } }
    end
    assert_redirected_to category_url(Category.last)
  end

  test "should get edit" do
    sign_in @user, scope: :user
    category = Category.create!(name: "Test Category", user: @user)
    get edit_category_url(category)
    assert_response :success
  end

  test "should update category" do
    sign_in @user, scope: :user
    category = Category.create!(name: "Test Category", user: @user)
    patch category_url(category), params: { category: { name: "Updated Category" } }
    assert_redirected_to category_url(category)
    category.reload
    assert_equal "Updated Category", category.name
  end
end
