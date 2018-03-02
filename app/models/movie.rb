class Movie < ApplicationRecord
  validates :title, :body, :release_date, :rating, :director, presence: true
  validates :title, uniqueness: true
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage/
  validates_attachment_file_name :image, matches: [/png\z/, /jpe?g\z/]

  validates_attachment_size :image, less_than: 300.kilobytes
end
