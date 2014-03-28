class AddAdminToUsers < ActiveRecord::Migration
  #created by [ rails generate migration add_admin_to_users admin:boolean ]
  def change
    add_column :users, :admin, :boolean, default: false
    #default is an attribute of "boolean"
  end
end
