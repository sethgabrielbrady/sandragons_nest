class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :username
      t.boolean :admin_user

      t.timestamps
    end
  end
end
