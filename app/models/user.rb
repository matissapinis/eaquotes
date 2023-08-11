class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :display_name, presence: true, uniqueness: true

  ## Quotes associations and validations:
  has_many :quotes, dependent: :destroy

  ## Favorites associations:
  has_many :favorites
  has_many :favorited_quotes, through: :favorites, source: :quote

  ## Upvotes and downvotes associations:
  has_and_belongs_to_many :upvoted_quotes, class_name: "Quote", join_table: :upvotes
  has_and_belongs_to_many :downvoted_quotes, class_name: "Quote", join_table: :downvotes

  ## For user's settings page where they can toggle the display of their full name and favorites on their profile:
  # t.boolean :display_full_name, default: true
  # t.boolean :display_favorites, default: true

  def admin?
    self.admin
  end
end
