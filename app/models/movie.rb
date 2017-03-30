class Movie < ApplicationRecord
  validates :filmname, presence: true
  belongs_to :user
  has_many :reviews
  has_many :movies_relationships
  has_many :members, through: :movies_relationships, source: :user
end
