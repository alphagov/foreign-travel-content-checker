# frozen_string_literal: true

require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  include ForeignTravelAdviceApiHelper

  setup do
    stub_foreign_travel_advice_api
  end

  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get show" do
    get location_url("spain")
    assert_response :success
  end

  test "should get update" do
    get update_url
    assert_response :redirect
  end

  test "should get completed" do
    get completed_url
    assert_response :success
  end

  test "should return 500 when date is beyond the deadline date" do
    travel_to Time.zone.local(2022, 0o6, 0o2)
    assert_raises(StandardError) do
      get root_url
    end
    assert_raises(StandardError) do
      get location_url("spain")
    end
    assert_raises(StandardError) do
      get update_url
    end
    assert_raises(StandardError) do
      get completed_url
    end
    travel_back
  end
end
