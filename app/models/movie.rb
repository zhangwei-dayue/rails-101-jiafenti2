class Movie < ApplicationRecord
  validates :filmname, presence: true
  belongs_to :user
end
