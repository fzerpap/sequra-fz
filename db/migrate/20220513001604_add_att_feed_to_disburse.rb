class AddAttFeedToDisburse < ActiveRecord::Migration[7.0]
  def change
    add_column :disburses, :feed, :decimal, scale: 2, precision: 12, default: 0.0
  end
end
