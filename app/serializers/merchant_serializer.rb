class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :cif
end
