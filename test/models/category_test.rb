require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "should be valid with name" do
    category = Category.new(name: "Test Category", user: @user)
    assert category.valid?
  end

  test "should be invalid without name" do
    category = Category.new(user: @user)
    refute category.valid?
    assert_includes category.errors[:name], "can't be blank"
  end

  test "should be invalid with name too long" do
    category = Category.new(name: "a" * 101, user: @user)
    refute category.valid?
    assert_includes category.errors[:name], "is too long (maximum is 100 characters)"
  end

  test "should allow duplicate names for different users" do
    other_user = User.create!(
      email: "other@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    Category.create!(name: "Shared Name", user: @user)
    category2 = Category.new(name: "Shared Name", user: other_user)
    assert category2.valid?
  end

  test "should not allow duplicate names for same user" do
    Category.create!(name: "Unique Name", user: @user)
    category2 = Category.new(name: "Unique Name", user: @user)
    refute category2.valid?
    assert_includes category2.errors[:name], "You already have a category with this name"
  end
end
