require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  @@email = "example@example.com"
  @@password = "example"
  @@full_name = "example"

  @@code = "examplecode"

  test "login" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)

    invalid_params = {email: "invalid", password: "invalid"}
    invalid_credentials = {successfull: false, errors: ["Invalid Credentials"]}.to_json
    post "/login", params: invalid_params
    assert_equal invalid_credentials, @response.body

    params = {email: @@email, password: @@password}
    post "/login", params: params
    assert @response.body =~ /code/

    error_res = {successfull: false, errors: ["you should not be signed in"]}.to_json
    auth = Auth.create(code: @@code, author_id: user.id)
    post "/login", params: params, headers: {'Authorization' => @@code}
    assert_equal error_res, @response.body
  end

  test "logout" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)

    delete "/logout"
    error_res = {successfull: false, errors: ["Unauthorized"]}.to_json
    assert_equal error_res, @response.body

    auth = Auth.create(code: @@code, author_id: user.id)
    res = {successfull: true}.to_json
    delete "/logout", headers: {'Authorization' => @@code}
    assert_equal res, @response.body
  end
end
