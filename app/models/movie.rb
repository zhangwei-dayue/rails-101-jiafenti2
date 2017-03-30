class Movie < ApplicationRecord
  validates :filmname, presence: true
  belongs_to :user
  has_many :reviews
end
