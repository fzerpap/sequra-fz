class OrderSerializer < ActiveModel::Serializer
  attributes :id, :amount, :completed_at

  belongs_to :merchant
  belongs_to :shopper
  
end
