class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |u|
      u.string :long_url
      u.string :short_url
      u.integer :click_counter, :default => 0
      u.integer :user_id
      u.timestamps
    end
  end
end