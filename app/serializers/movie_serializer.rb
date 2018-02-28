class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :release_date, :rating, :director
end
