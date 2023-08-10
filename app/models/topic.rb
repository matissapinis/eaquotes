class Topic < ApplicationRecord
    has_many :quotes_topics
    has_many :quotes, through: :quotes_topics
    ## Validation to ensure topic names are unique:
    validates :name, uniqueness: true
end
