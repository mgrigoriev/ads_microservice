class CreateAds < ActiveRecord::Migration[7.0]
  def change
    create_table :ads do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.string :city, null: false
      t.float :lat
      t.float :lon
      t.timestamps
    end
  end
end
