class CreateQuotesTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes_topics do |t|
      t.references :quote, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
