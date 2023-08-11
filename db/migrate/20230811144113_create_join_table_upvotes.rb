class CreateJoinTableUpvotes < ActiveRecord::Migration[7.0]
  def change
    #### create_join_table :users, :quotes do |t|
    create_join_table :users, :quotes, table_name: :upvotes do |t|
      # t.index [:user_id, :quote_id] ## Uncomment for indices on join table (fast lookups, slower writes).
      # t.index [:quote_id, :user_id]
    end
  end
end
