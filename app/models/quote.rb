class Quote < ApplicationRecord
    ## Associations and validations:
    belongs_to :user

    ## Check whether a quote belongs to a given user:
    def owned_by?(user)
        self.user == user
    end

    validates :content, presence: true
    validates :attribution, presence: true

    ## Custom validation – the `source_link` should only be allowed if `source` is present:
    validate :source_link_requires_source
    
    private
    
    def source_link_requires_source
      if source_link.present? && source.blank?
        errors.add(:source_link, "cannot be present without a source")
      end
    end
end
