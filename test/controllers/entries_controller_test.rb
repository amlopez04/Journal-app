require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    @category = Category.create!(name: "Test Category", user: @user)
    @entry = Entry.create!(
      title: "Test Entry",
      content: "This is test content",
      category: @category,
      user: @user
    )
  end

  test "should get new" do
    sign_in @user, scope: :user
    get new_category_entry_url(@category)
    assert_response :success
  end

  test "should create entry" do
    sign_in @user, scope: :user
    assert_difference("Entry.count") do
      post category_entries_url(@category), params: {
        entry: {
          title: "New Entry",
          content: "This is a new entry"
        }
      }
    end
    assert_redirected_to category_entry_url(@category, Entry.last)
  end

  test "should show entry" do
    sign_in @user, scope: :user
    get category_entry_url(@category, @entry)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user, scope: :user
    get edit_category_entry_url(@category, @entry)
    assert_response :success
  end

  test "should update entry" do
    sign_in @user, scope: :user
    patch category_entry_url(@category, @entry), params: {
      entry: {
        title: "Updated Entry",
        content: "Updated content"
      }
    }
    assert_redirected_to category_entry_url(@category, @entry)
    @entry.reload
    assert_equal "Updated Entry", @entry.title
    assert_equal "Updated content", @entry.content
  end

  test "should destroy entry" do
    sign_in @user, scope: :user
    assert_difference("Entry.count", -1) do
      delete category_entry_url(@category, @entry)
    end
    assert_redirected_to category_url(@category)
  end

  test "should require authentication for new" do
    get new_category_entry_url(@category)
    assert_redirected_to new_user_session_url
  end

  test "should only allow entry owner to edit" do
    other_user = User.create!(
      email: "other@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    sign_in other_user, scope: :user
    get edit_category_entry_url(@category, @entry)
    assert_response :forbidden
  end
end
