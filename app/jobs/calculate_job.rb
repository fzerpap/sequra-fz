class CalculateJob < ApplicationJob
  queue_as :default

  #def perform(*args)
  def perform(init_date, end_date)

    Disburse.calculate_disbursements(init_date, end_date)
     
  end
end
