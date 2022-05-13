class Disburse < ApplicationRecord
  belongs_to :merchant

  # Calculate the disbursements, feeds and quantity of orders to every merchant, for period of dates. 
  # The calculates are saved to the data base
  def self.calculate_disbursements(init_date=nil, end_date=nil)
    # Valid dates
    msg = validate_week(init_date, end_date)
    return msg if msg != 'ok'

    if self.where('init_date =? and end_date =?',init_date, end_date).any?
      return 'Error: The calculations were already made for those dates'
    end

    # get the orders between dates and transfor in array
    orders = Order.where(completed_at: init_date..end_date).order(:merchant_id).map {|u| u }
    if orders.blank?
      return "Error: There aren't orders for those dates"
    end
    
    # calculate the disbursements for every merchant
    i = 0
    result = []
    while i < orders.length
      merchant_disbursements =  merchant_orders = merchant_feeds = 0
      merchant_id = orders[i][:merchant_id]
      # for each merchant
      while orders[i][:merchant_id] == merchant_id
        amount = orders[i][:amount]
        case amount
        when amount <= 50
          feed = (1/100) * amount
        when amount >50 && amount <= 300
          feed = (0.95/100) * amount
        else
          feed = (0.85/100) * amount
        end
        merchant_disbursements += amount - feed
        merchant_feeds += feed
        merchant_orders += 1
        i += 1
        break if i >= orders.length

      end
      # Save in disburs table
      create(merchant_id: merchant_id, amount: merchant_disbursements, feed: merchant_feeds,
              orders: merchant_orders, init_date: init_date, end_date: end_date)

      result << {merchant_id: merchant_id, amount: merchant_disbursements}
      
    end
    return result

  end

  # get the disbursements for a week. If a merchant is valid, them the report will be for a merchant, else, will be for all merchants
  def self.get_week_merchant(init_date, end_date, merchant_id)
    # Valid dates
    msg = validate_week(init_date, end_date)
    return msg if msg != 'ok'

    if !merchant_id.blank?
      disburses = where('init_date =? and end_date=? and merchant_id=?',init_date, end_date, merchant_id).order(:merchant_id)
    else 
      disburses = where('init_date =? and end_date=?',init_date, end_date).order(:merchant_id)

    end
    return disburses

  end

  private
  
  # validate that the dates define a week between manday and sunday
  def self.validate_week(init_date, end_date)
    return 'Error: params empty' if init_date.nil? || end_date.nil?
    if  init_date.strftime('%A') != 'Monday' || end_date.strftime('%A') != 'Sunday' || (end_date.to_date - init_date.to_date) != 6
      return 'Error: Dates invalid. Only accept dates betwwen monday and sunday, for one week'
    else 
      return "ok"
    end
  end

end
