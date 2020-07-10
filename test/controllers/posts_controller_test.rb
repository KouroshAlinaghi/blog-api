require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  @@email = "example@example.com"
  @@password = "example"
  @@full_name = "example"

  @@title = "exampletitle"
  @@body = "examplebody"

  @@code = "examplecode"

  test "list posts" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    post = user.posts.create(title: @@title, body: @@body)
    res = {successfull: true, posts: [post]}.to_json
    get "/posts"
    assert_equal res, @response.body
  end

  test "show post" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    post = user.posts.create(title: @@title, body: @@body)
    get "/posts/#{post.id}"
    res = {successfull: true, post: post}.to_json
    assert_not_equal res, @response.body
  end

  test "create post" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    auth = Auth.create(code: @@code, author_id: user.id)
    params = {post: {author_id: user.id, title: @@title, body: @@body}}
    res = {"successfull" => true}.to_json
    error_res = {successfull: false, errors: ["Unauthorized"]}.to_json
    post "/posts", params: params, headers: {'Authorization' => auth.code}
    assert_equal res, @response.body
    post "/posts", params: params
    assert_equal error_res, @response.body
  end

  test "update post" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    auth = Auth.create(code: @@code, author_id: user.id)
    post = user.posts.create(title: @@title, body: @@body)
    params = {post: {title: "new"+@@title, body: "new"+@@body}}
    res = {"successfull" => true}.to_json
    error_res = {successfull: false, errors: ["Unauthorized"]}.to_json
    put "/posts/#{post.id}", params: params, headers: {'Authorization' => auth.code}
    assert_equal res, @response.body
    put "/posts/#{post.id}", params: params
    assert_equal error_res, @response.body
  end
end
