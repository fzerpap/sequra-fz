class Merchant < ApplicationRecord
    has_many :orders
    has_many :disburses

    # get the data merchants since json, only those not exist in merchants table
    def self.import()
        return {status: 400, message: 'Error: The json merchants file not exist'} if !File.exist?('./db/dataset/merchants.json')
        
        file = File.read('./db/dataset/merchants.json')
        merchants_json = JSON.parse(file)['RECORDS']
        #
        merchants_json.each do |merchant|
            merchant_db = find( merchant['id']) rescue nil
            if merchant_db.nil?
                create(id: merchant['id'], name: merchant['name'], email: merchant['email'], cif: merchant['cif'])
            end

        end
        return {status: 200, message: 'Json Merchants imported sucessfull'}

    end
end
