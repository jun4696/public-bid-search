class CreateMunicipalities < ActiveRecord::Migration[8.1]
  def change
    create_table :municipalities do |t|
      t.string :name, null: false
      t.string :prefecture, null: false

      t.timestamps
    end

    add_index :municipalities, 
              [:prefecture, :name],
              unique: true
  end
end
