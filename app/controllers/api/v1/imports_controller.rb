class Api::V1::ImportsController < ApplicationController
  

  # GET /orders
  def index
    resut_shoppers  = Shopper.import()
    result_merchants = Merchant.import()
    result_orders    = Order.import()
    
    render json: {shoppers: resut_shoppers, merchants:result_merchants, orders: result_orders}
  end

 
end
