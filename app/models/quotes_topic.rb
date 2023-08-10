class QuotesTopic < ApplicationRecord
  belongs_to :quote
  belongs_to :topic
end
