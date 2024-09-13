require "test_helper"

class EarthquakesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get earthquakes_index_url
    assert_response :success
  end

  test "should get show" do
    get earthquakes_show_url
    assert_response :success
  end

  test "should get create" do
    get earthquakes_create_url
    assert_response :success
  end

  test "should get update" do
    get earthquakes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get earthquakes_destroy_url
    assert_response :success
  end
end
