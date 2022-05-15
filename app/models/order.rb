class Order < ApplicationRecord
  belongs_to :shopper
  belongs_to :merchant

    # get the data orders since json, only merchant_id exist in merchants and shopper_id exist in shoppers table
    def self.import()
      return {status: 400, message: 'Error: The json orders file not exist'} if !File.exist?('./db/dataset/orders.json')

      # delete all orders
      delete_all
  
      file = File.read('./db/dataset/orders.json')
      orders_json = JSON.parse(file)['RECORDS']
      #
      orders_json.each do |order|
          merchant = Merchant.find(order['merchant_id']) rescue nil
          shopper  = Shopper.find(order['shopper_id']) rescue nil
          #
          if !(merchant.nil? && shopper.nil?)
              create(shopper_id: order['shopper_id'], merchant_id: order['merchant_id'], amount: order['amount'], 
                    completed_at: order['completed_at'].to_datetime)
          end

      end
      return {status: 200, message: 'Json Orders imported sucessfull'}

    end
end
