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

# class CreateUrls < ActiveRecord::Migration
#   def change
#     create_table :urls do |u|
#       u.string :long_url
#       u.string :short_url
#       u.integer :click_counter, :default => 0
#       u.integer :user_id
#       u.timestamps
#     end
#   end
# end
# class Urls < ActiveRecord::Migration
#   def change
#     create_table :urls do |u|
#       u.string :long_url
#       u.string :short_url
#       u.integer :click_counter, :default => 0
#       u.integer :user_id
#       u.timestamps
#     end
#   end
# end
