class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user
      t.string :full_name
      t.string :birthday
      t.string :email
      t.string :adress
      t.string :city
      t.string :country
      t.string :password
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
