require "test_helper"

class DisburseTest < ActiveSupport::TestCase

  # Tests for calculate_disbursements method
  test "calculate calculate_disbursements without dates" do
    result = Disburse.calculate_disbursements()
    assert_equal({status: 400, message: 'Error: params empty'},result)
  end

  test "calculate calculate_disbursements without dates one week" do
    result = Disburse.calculate_disbursements('2022-05-10'.to_datetime, '2022-05-10'.to_datetime+4)

    assert_equal({status: 400, message: 'Error: Dates invalid. Only accept dates betwwen monday and sunday, for one week'},result)
  end

  test "calculate calculate_disbursements without dates one exact week" do
    result = Disburse.calculate_disbursements('2022-05-08'.to_datetime, '2022-05-15'.to_datetime)

    assert_equal({status: 400, message: 'Error: Dates invalid. Only accept dates betwwen monday and sunday, for one week'},result)
  end

  test "calculate calculate_disbursements without orders" do
    result = Disburse.calculate_disbursements('2022-04-18'.to_datetime, '2022-04-24'.to_datetime)

    assert_equal({status: 400, message: "Error: There aren't orders for those dates"},result)
  end

  test "calculate calculate_disbursements with valid dates and orders" do
    result = Disburse.calculate_disbursements('2022-05-09 00:00:00'.to_datetime, '2022-05-15 23:59:59'.to_datetime)
  
    assert_equal(['Sorocaba Phones',798,'Elisa Shoes',1090],
                  [Merchant.find((result[0][:merchant_id]).to_i).name,result[0][:amount].to_i,
                  Merchant.find((result[1][:merchant_id].to_i)).name,result[1][:amount].to_i])
    
  end

end
