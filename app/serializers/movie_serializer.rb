class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :release_date, :rating, :director, :image

  def image
    object.image.url
  end
end
