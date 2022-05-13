require "test_helper"

class DisbursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @disburse = disburses(:one)
  end

  test "should get index" do
    get disburses_url, as: :json
    assert_response :success
  end

  test "should create disburse" do
    assert_difference("Disburse.count") do
      post disburses_url, params: { disburse: { amount: @disburse.amount, end_date: @disburse.end_date, init_date: @disburse.init_date, merchant_id: @disburse.merchant_id, orders: @disburse.orders } }, as: :json
    end

    assert_response :created
  end

  test "should show disburse" do
    get disburse_url(@disburse), as: :json
    assert_response :success
  end

  test "should update disburse" do
    patch disburse_url(@disburse), params: { disburse: { amount: @disburse.amount, end_date: @disburse.end_date, init_date: @disburse.init_date, merchant_id: @disburse.merchant_id, orders: @disburse.orders } }, as: :json
    assert_response :success
  end

  test "should destroy disburse" do
    assert_difference("Disburse.count", -1) do
      delete disburse_url(@disburse), as: :json
    end

    assert_response :no_content
  end
end
