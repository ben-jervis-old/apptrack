require 'test_helper'

class LendersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lender = lenders(:one)
  end

  test "should get index" do
    get lenders_url
    assert_response :success
  end

  test "should get new" do
    get new_lender_url
    assert_response :success
  end

  test "should create lender" do
    assert_difference('Lender.count') do
      post lenders_url, params: { lender: { favourite: @lender.favourite, name: @lender.name } }
    end

    assert_redirected_to lender_url(Lender.last)
  end

  test "should show lender" do
    get lender_url(@lender)
    assert_response :success
  end

  test "should get edit" do
    get edit_lender_url(@lender)
    assert_response :success
  end

  test "should update lender" do
    patch lender_url(@lender), params: { lender: { favourite: @lender.favourite, name: @lender.name } }
    assert_redirected_to lender_url(@lender)
  end

  test "should destroy lender" do
    assert_difference('Lender.count', -1) do
      delete lender_url(@lender)
    end

    assert_redirected_to lenders_url
  end
end
