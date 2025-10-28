require "test_helper"

class EntryTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    @category = Category.create!(name: "Test Category", user: @user)
  end

  test "should be valid with title and content" do
    entry = Entry.new(
      title: "My Entry",
      content: "This is my journal entry content.",
      category: @category,
      user: @user
    )
    assert entry.valid?
  end

  test "should be invalid without title" do
    entry = Entry.new(
      content: "This is my journal entry content.",
      category: @category,
      user: @user
    )
    refute entry.valid?
    assert_includes entry.errors[:title], "can't be blank"
  end

  test "should be invalid without content" do
    entry = Entry.new(
      title: "My Entry",
      category: @category,
      user: @user
    )
    refute entry.valid?
    assert_includes entry.errors[:content], "can't be blank"
  end

  test "should be invalid with title too long" do
    entry = Entry.new(
      title: "a" * 201,
      content: "Content",
      category: @category,
      user: @user
    )
    refute entry.valid?
    assert_includes entry.errors[:title], "is too long (maximum is 200 characters)"
  end

  test "should be invalid with content too long" do
    entry = Entry.new(
      title: "Title",
      content: "a" * 10001,
      category: @category,
      user: @user
    )
    refute entry.valid?
    assert_includes entry.errors[:content], "is too long (maximum is 10000 characters)"
  end

  test "should belong to category" do
    entry = Entry.create!(
      title: "My Entry",
      content: "Content",
      category: @category,
      user: @user
    )
    assert_equal @category, entry.category
  end

  test "should belong to user" do
    entry = Entry.create!(
      title: "My Entry",
      content: "Content",
      category: @category,
      user: @user
    )
    assert_equal @user, entry.user
  end
end
