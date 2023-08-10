class AddDetailsToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :attribution, :string
    add_column :quotes, :source, :string
    add_column :quotes, :source_link, :string
    add_column :quotes, :comment, :text
    add_reference :quotes, :user, foreign_key: true
  end
end
