class Api::V1::RatingsController < ApplicationController
  def create
  	movie = Movie.find(params[:movie_id])
  	rating = movie.ratings.new(rating_params.merge(user: current_api_v1_user))
  	if rating.save
  		render status: 200
  	else
  		render json: { errors: rating.errors.full_messages },
             status: 422
  	end
  end

  def destroy
    movie = Movie.find(params[:movie_id])
    movie.ratings.delete(params[:id])
    render status: 200
  end

  def update
    movie = Movie.find(params[:movie_id])
    rating = movie.ratings.find(params[:id])
    rating.update(rating_params) ? (render status: 200) : rating_error(rating)
  end

  private

  def rating_params
  	params.require(:rating).permit!
  end

  def rating_error(obj)
    render json: { errors: obj.errors.full_messages },
          status: 422
  end
end
