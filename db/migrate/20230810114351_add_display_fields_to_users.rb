class AddDisplayFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :display_full_name, :boolean
    add_column :users, :display_favorites, :boolean
  end
end
