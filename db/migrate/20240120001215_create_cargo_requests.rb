class CreateCargoRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :cargo_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :phone
      t.string :email
      t.float :weight
      t.float :length
      t.float :width
      t.float :height
      t.string :departure_point
      t.string :destination
      t.float :distance
      t.float :price

      t.timestamps
    end
  end
end
