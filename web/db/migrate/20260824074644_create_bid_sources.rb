class CreateBidSources < ActiveRecord::Migration[8.1]
  def change
    create_table :bid_sources do |t|
      t.references :bid,
                   null: false,
                   foreign_key: true

      t.references :source,
                   null: false,
                   foreign_key: true

      t.string :format, null: false

      t.string :external_id
      t.string :source_url, null: false

      t.string :content_hash
      t.datetime :fetched_at, null: false

      t.timestamps
    end

    add_index :bid_sources,
              [:source_id, :external_id],
              unique: true,
              where: "external_id IS NOT NULL"

    add_index :bid_sources, :content_hash
    add_index :bid_sources, :fetched_at
  end
end