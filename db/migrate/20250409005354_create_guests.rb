class CreateGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
