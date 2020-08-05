class CreateReadings < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :image_url
      t.string :location
      t.string :genre 
      #could later on add DateTime to it
      t.integer :user_id

      t.timestamps null: false

    end
  end
end
