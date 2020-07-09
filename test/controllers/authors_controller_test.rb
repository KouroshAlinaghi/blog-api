require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest

  @@email = "example@example.com"
  @@password = "example"
  @@full_name = "example"
  
  @@code = "examplecode"

  test "get dashboard when signed in" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    auth = Auth.create(code: @@code, author_id: user.id)
    res = {"successfull" => true, "user" => user}.to_json
    error_res = {successfull: false, errors: ["Unauthorized"]}.to_json
    get "/dashboard", headers: {'Authorization' => auth.code}
    assert_equal res, @response.body
    get "/dashboard"
    assert_equal error_res, @response.body
  end

  test "create author" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    auth = Auth.create(code: @@code, author_id: user.id)
    params = {author: {full_name: @@full_name, email: "new"++@@email, password: @@password, password_confirmation: @@password}}
    error_res = {successfull: false, errors: ["Unauthorized"]}.to_json
    res = {successfull: true}.to_json
    post "/sign_up", params: params, headers: {'Authorization' => auth.code}
    assert_equal res, @response.body
    post "/sign_up", params: params
    assert_equal error_res, @response.body
  end

  test "update author" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    auth = Auth.create(code: @@code, author_id: user.id)
    params = {author: {full_name: "new"+@@full_name}}
    error_res = {successfull: false, errors: ["Unauthorized"]}.to_json
    res = {successfull: true}.to_json
    put "/dashboard", params: params, headers: {'Authorization' => auth.code}
    assert_equal res, @response.body
    put "/dashboard", params: params
    assert_equal error_res, @response.body
  end

  test "destroy author" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    auth = Auth.create(code: @@code, author_id: user.id)
    params = {author: {full_name: "new"+@@full_name}}
    error_res = {successfull: false, errors: ["Unauthorized"]}.to_json
    res = {successfull: true}.to_json
    delete "/dashboard", params: params, headers: {'Authorization' => auth.code}
    assert_equal res, @response.body
    delete "/dashboard", params: params
    assert_equal error_res, @response.body
  end
end
