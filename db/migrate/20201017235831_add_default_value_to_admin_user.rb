class AddDefaultValueToAdminUser < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :admin_user, false
  end
end
