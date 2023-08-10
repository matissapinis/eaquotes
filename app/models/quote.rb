class Quote < ApplicationRecord
    ## Pagination:
    self.per_page = 2

    ## Associations and validations:
    belongs_to :user

    ## Favorites associations:
    has_many :favorites
    has_many :favoriting_users, through: :favorites, source: :user  
    
    ## Topics associations:
    has_many :quotes_topics
    has_many :topics, through: :quotes_topics

    ## Check whether a quote belongs to a given user:
    def owned_by?(user)
        self.user == user
    end

    validates :content, presence: true
    validates :attribution, presence: true

    ## Custom validation – the `source_link` should only be allowed if `source` is present:
    validate :source_link_requires_source
    
    ## Custom setter and getter methods for topics:
    def topic_names=(names)
        self.topics = names.split(",").map do |name|
            Topic.where(name: name.strip).first_or_create!
        end
    end
    
    def topic_names
        self.topics.map(&:name)
    end    

    private
    
    def source_link_requires_source
      if source_link.present? && source.blank?
        errors.add(:source_link, "cannot be present without a source")
      end
    end
end
