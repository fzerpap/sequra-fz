class CreateDisburses < ActiveRecord::Migration[7.0]
  def change
    create_table :disburses do |t|
      t.datetime :init_date
      t.datetime :end_date
      t.integer :orders
      t.decimal :amount, scale: 2, precision: 12, default: 0.0
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
