class CreateBidDocuments < ActiveRecord::Migration[8.1]
  def change
    create_table :bid_documents do |t|
      t.references :bid,
                    null: false,
                    foreign_key: true

      t.string :name, null: false
      t.string :document_type, null: false
      t.string :format, null: false

      t.string :external_id
      t.string :url, null: false

      t.string :content_hash
      t.datetime :fetched_at, null: false

      t.timestamps
    end

    add_index :bid_documents,
              [:bid_id, :external_id],
              unique: true

    add_index :bid_documents,  :document_type
    add_index :bid_documents,  :format
    add_index :bid_documents,  :content_hash            
  end
end
