require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "invalid without name" do
    u = User.new(email: "test@example.com", password: "secret")
    refute u.valid?
  end

  test "invalid without email" do
    u = User.new(name: "Alice", password: "secret")
    refute u.valid?
  end

  test "invalid without password" do
    u = User.new(name: "Alice", email: "alice@example.com")
    refute u.valid?
  end

  test "valid with name, email, and password" do
    u = User.new(name: "Alice", email: "alice@example.com", password: "secret")
    assert u.valid?
  end
end
