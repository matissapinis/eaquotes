class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :display_name, :string
    add_column :users, :full_name, :string
    add_column :users, :facebook_link, :string
    add_column :users, :twitter_link, :string
    add_column :users, :ea_forum_link, :string
    add_column :users, :lesswrong_link, :string
    add_column :users, :goodreads_link, :string
  end
end
