class Api::V1::ReviewsController < ApplicationController
  def create
  	movie = Movie.find(params[:movie_id])
  	review = movie.reviews.new(review_params)
  	review.user = current_api_v1_user
  	if review.save
  		render status: 200
  	else
  		render status: 422
  	end
  end

  def destroy
  	movie = Movie.find(params[:movie_id])
  	movie.reviews.delete(params[:id])
  	render status: 200
  end

  def update
    movie = Movie.find(params[:movie_id])
    review = movie.reviews.find(params[:id])
    if review.update(review_params)
       render status: 200
     else
      render status: 422
    end
  end

  private

  def review_params
  	params.require(:review).permit(:body)
  end
end
