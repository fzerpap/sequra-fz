class Shopper < ApplicationRecord
    
    has_many :orders

    validates :name, :email, :nif, presence: true, uniqueness: true

    # get the data shoppers since json, only those not exist in shoppers table
    def self.import()
        return {status: 400, message: 'Error: The json shoppers file not exist'} if !File.exist?('./db/dataset/shoppers.json')
        
        file = File.read('./db/dataset/shoppers.json')
        shoppers_json = JSON.parse(file)['RECORDS']
        #
        shoppers_json.each do |shopper|
            shopper_db = find( shopper['id']) rescue nil
            if shopper_db.nil?
                create(id: shopper['id'], name: shopper['name'], email: shopper['email'], nif: shopper['nif'])
            end

        end
        return {status: 200, message: 'Json Soppers imported sucessfull'}

    end

end
