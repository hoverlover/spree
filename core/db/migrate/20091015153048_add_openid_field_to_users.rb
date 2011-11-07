class AddOpenidFieldToUsers < ActiveRecord::Migration
  def up
    add_column :users, :openid_identifier, :string
    add_index :users, :openid_identifier

    change_column :users, :login, :string, :default => nil, :null => true
    change_column :users, :crypted_password, :string, :default => nil, :null => true
    change_column :users, :salt, :string, :default => nil, :null => true
  end

  def down
    remove_column :users, :openid_identifier

    [:login, :crypted_password, :salt].each do |field|
      Spree::User.where(field => nil).each { |user| user.update_attribute(field, '') if user.send(field).nil? }
      change_column :users, field, :string, :default => '', :null => false
    end
  end
end
