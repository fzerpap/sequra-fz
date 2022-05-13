require "test_helper"

class ShoppersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shopper = shoppers(:one)
  end

  test "should get index" do
    get shoppers_url, as: :json
    assert_response :success
  end

  test "should create shopper" do
    assert_difference("Shopper.count") do
      post shoppers_url, params: { shopper: { cif: @shopper.cif, email: @shopper.email, name: @shopper.name } }, as: :json
    end

    assert_response :created
  end

  test "should show shopper" do
    get shopper_url(@shopper), as: :json
    assert_response :success
  end

  test "should update shopper" do
    patch shopper_url(@shopper), params: { shopper: { cif: @shopper.cif, email: @shopper.email, name: @shopper.name } }, as: :json
    assert_response :success
  end

  test "should destroy shopper" do
    assert_difference("Shopper.count", -1) do
      delete shopper_url(@shopper), as: :json
    end

    assert_response :no_content
  end
end
