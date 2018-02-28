class Movie < ApplicationRecord
  validates :title, :body, :release_date, :rating, :director, presence: true
  validates :title, uniqueness: true
end
