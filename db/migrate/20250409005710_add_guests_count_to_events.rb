class AddGuestsCountToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :guests_count, :integer, default: 0, null: false
  end
end
