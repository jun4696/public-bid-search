class CreateSources < ActiveRecord::Migration[8.1]
  def change
    create_table :sources do |t|
      t.references :municipality, 
                    null: false, 
                    foreign_key: true
      
      t.string :name, null: false
      t.string :url, null: false
      t.string :source_type, null: false
      
      t.timestamps
    end

    add_index :sources,
              [:municipality_id, :name],
              unique: true
  end
end
