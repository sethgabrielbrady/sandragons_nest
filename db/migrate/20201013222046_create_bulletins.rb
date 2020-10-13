class CreateBulletins < ActiveRecord::Migration[5.2]
  def change
    create_table :bulletins do |t|
      t.string :label
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
