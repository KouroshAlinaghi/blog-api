require 'test_helper'

class PostTest < ActiveSupport::TestCase

  @@title = "exampletitle"
  @@body = "examplebody"
  
  @@email = "example@example.com"
  @@password = "example"
  @@full_name = "example"

  test "only save posts with valid data" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    p_without_title = user.posts.new(body: @@body)
    p_without_body = user.posts.new(title: @@title)
    p_without_author = Post.new(title: @@title, body: @@body)

    for post in [p_without_title, p_without_body, p_without_author] 
      assert_not post.save
    end
  end

  test "save post with valid data" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    post = user.posts.new(body: @@body, title: @@title)
    assert post.save
  end

  test "destroy post when auth deleted" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    post =  Post.create(title: @@title, body: @@body, author_id: user.id)
    user.destroy
    assert_not Post.exists?(title: @@title, body: @@body, author_id: user.id)
  end

  test "unique title" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    valid_post =  Post.create(title: @@title, body: @@body, author_id: user.id)
    invalid_post =  Post.new(title: @@title, body: @@body, author_id: user.id)
    assert_raises(ActiveRecord::RecordNotUnique) do
      invalid_post.save
    end
  end

  test "visit_count default value" do
    user = Author.create(email: @@email, password: @@password, password_confirmation: @@password, full_name: @@full_name)
    valid_post =  Post.create(title: @@title, body: @@body, author_id: user.id)
    assert valid_post.visit_count == 0
    4.times {valid_post.inc_visit_count}
    assert valid_post.visit_count == 4
  end

end
