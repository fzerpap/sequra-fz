class DisburseSerializer < ActiveModel::Serializer
    attributes :id,:init_date,:end_date,:amount,:feed,:orders
  
    #def attributes(*args)
    #  h = super(*args)
    #  h[:init_date] = I18n.l(object.init_date.to_time.iso8601)
    #end

    belongs_to :merchant do
      link(:related) { api_v1_merchant_url( object.id ) }
    end
  
    #has_many :merchants do
      #link(:related) {api_v1_city_url(object.id)}
    #end

    meta do 
        {author: 'Francisco Zerpa'}
    end
  end
  