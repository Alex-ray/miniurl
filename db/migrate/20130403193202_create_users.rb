class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :user_name
      u.string :email
      u.text :password_hash
      u.text :password_salt
      u.timestamps
    end
  end
end
