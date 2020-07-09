require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

  @@email = "example@example.com"
  @@password = "example"
  @@full_name = "example"
  
  test "only save author with valid data" do
    a_without_email = Author.new(password: @@password, full_name: @@full_name, password_confirmation: @@password)
    a_without_full_name = Author.new(password: @@password, email: @@email, password_confirmation: @@password)
    a_without_password = Author.new(full_name: @@full_name, email: @@email)
    a_with_invalid_password_confirmation = Author.new(full_name: @@full_name, email: @@email, password: @@password, password_confirmation: "Invalid Data")
    for author in [a_without_email, a_without_full_name, a_without_password, a_with_invalid_password_confirmation] do
      assert_not author.save
    end
  end

  test "save author with valid date" do
    author = Author.new(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    assert author.save
  end

  test "dont save non-unique emailed author" do
    valid_author = Author.new(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    valid_author.save
    invalid_author = Author.new(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    assert_raises(ActiveRecord::RecordNotUnique) do
      invalid_author.save
    end
  end

end
