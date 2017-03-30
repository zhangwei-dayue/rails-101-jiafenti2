class Movie < ApplicationRecord
  validates :filmname, presence: true
end
