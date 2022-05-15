# README

Development of an API application (web service) that allows managing merchants, shoppers, orders and calculation and report of disbursements to merchants for completed orders


TECHNICAL ASPECTS:

* Framework to development: Ruby on Rails (API)

* Ruby version: 3.0.3

* Rails version: 7.0.3

* Data base design: /bd/DataBaseModel.png

* Test data: /test/fixtures/TestData.xlsx. These data were implemented in fixtures

* Data base implementation: Postgresql

* How to run the test (only calculate how much money should be disbursed to each merchant ): rake test TEST=test/models/disburse_test.rb

* Services: sidekiq, Redis (for background jobs)

* Installed systems: Postgres, Redis


* DEPLOYMENT INSTRUCTIONS (Development mode)
    * rails server
    * sudo service redis-server start
    * bundle exec sidekiq
    * rails db:create (to create de development and test data base)
    * rails db:migrate
    * rake test TEST=test/models/disburse_test.rb
    * User Instructions:
        * For import data from json file: localhost:3000/api/v1/imports
        * Calculate how much money should be disbursed to each merchant: post localhost:3000/api/v1/disburses. 
            Add to body for instance: {"init_date": "2018-01-01", "end_date": "2018-01-07"}
        *  expose the disbursements for a given merchant on a given week: localhost:3000/api/v1/disburses?
                                                                            init_date=2018-01-01&end_date=2018-01-07&merchant=1 
        * expose merchants: get  localhost:3000/api/v1/merchants  
        * expose shoppers: get  localhost:3000/api/v1/shoppers
        * expose orders: get  localhost:3000/api/v1/orders



