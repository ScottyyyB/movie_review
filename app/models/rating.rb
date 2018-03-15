class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :number, presence: true
end
