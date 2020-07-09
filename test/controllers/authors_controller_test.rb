require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get authors_new_url
    assert_response :success
  end

  test "should get create" do
    get authors_create_url
    assert_response :success
  end

  test "should get dashboard" do
    get authors_dashboard_url
    assert_response :success
  end

  test "should get edit" do
    get authors_edit_url
    assert_response :success
  end

  test "should get update" do
    get authors_update_url
    assert_response :success
  end

end
