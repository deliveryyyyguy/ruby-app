class Article < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 50 }
  validates :user_id, presence: true
end