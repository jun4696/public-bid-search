class CreateBids < ActiveRecord::Migration[8.1]
  def change
    create_table :bids do |t|
      t.string :title, null: false

      t.string :status
      t.string :source_status
      t.string :category

      t.string :location
      t.string :department
      
      t.date :announcement_date
      t.date :application_start
      t.date :application_end
      t.date :bid_date

      t.string :project_period
      t.date :project_period_start
      t.date :project_period_end

      t.text :summary
      t.text :qualification

      t.string :contract
      t.decimal :bid_amount, precision: 15, scale: 2
      
      t.timestamps
    end

    add_index :bids, :title
    add_index :bids, :status
    add_index :bids, :category
    add_index :bids, :announcement_date
    add_index :bids, :application_end
    add_index :bids, :bid_date
  end
end
