require "test_helper"

class MerchantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @merchant = merchants(:one)
  end

  test "should get index" do
    get merchants_url, as: :json
    assert_response :success
  end

  test "should create merchant" do
    assert_difference("Merchant.count") do
      post merchants_url, params: { merchant: { cif: @merchant.cif, email: @merchant.email, name: @merchant.name } }, as: :json
    end

    assert_response :created
  end

  test "should show merchant" do
    get merchant_url(@merchant), as: :json
    assert_response :success
  end

  test "should update merchant" do
    patch merchant_url(@merchant), params: { merchant: { cif: @merchant.cif, email: @merchant.email, name: @merchant.name } }, as: :json
    assert_response :success
  end

  test "should destroy merchant" do
    assert_difference("Merchant.count", -1) do
      delete merchant_url(@merchant), as: :json
    end

    assert_response :no_content
  end
end
