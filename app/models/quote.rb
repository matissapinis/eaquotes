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

    ## Upvotes and downvotes associations:
    has_and_belongs_to_many :upvoted_users, class_name: "User", join_table: :upvotes
    has_and_belongs_to_many :downvoted_users, class_name: "User", join_table: :downvotes

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

    ## Methods to add and remove topics by name:
    def add_topic_by_name(name)
        topic = Topic.find_or_create_by(name: name)
        self.topics << topic unless self.topics.include?(topic)
    end
    
    def remove_topic_by_name(name)
        topic = Topic.find_by(name: name)
        self.topics.delete(topic) if topic && self.topics.include?(topic)
    end

    ## Check if a user has upvoted or downvoted a particular quote:
    def upvoted_by?(user)
        self.upvoted_users.include?(user)
    end
    
    def downvoted_by?(user)
        self.downvoted_users.include?(user)
    end
    

    private
    
    def source_link_requires_source
      if source_link.present? && source.blank?
        errors.add(:source_link, "cannot be present without a source")
      end
    end
end
