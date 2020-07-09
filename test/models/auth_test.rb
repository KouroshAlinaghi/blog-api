require 'test_helper'

class AuthTest < ActiveSupport::TestCase

  @@email = "example@example.com"
  @@password = "example"
  @@full_name = "example"

  @@code = "examplecode"

  test "only save author with valid data" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    a_without_code = user.auths.new()
    a_without_user = Auth.new(code: @@code)
    for auth in [a_without_code, a_without_user]
      assert_not auth.save
    end
  end

  test "save auth with valid data" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    auth1 = Auth.new(code: @@code, author_id: user.id)
    auth2 = user.auths.new(code: @@code)
    assert auth1.save && auth2.save
  end

  test "destroy auths when auth deleted" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    auth = Auth.create(code: @@code, author_id: user.id)
    user.destroy
    assert_not Auth.exists?(code: @@code, author_id: user.id)
  end
end
