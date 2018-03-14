class Api::V1::ReviewsController < ApplicationController
  def create
  	movie = Movie.find(params[:movie_id])
  	review = movie.reviews.new(review_params)
  	review.user = current_api_v1_user
  	if review.save
  		render json: { status: :ok }
  	else
  		render json: { status: :unprocessable_entity }
  	end
  end

  def destroy
  	movie = Movie.find(params[:movie_id])
  	movie.reviews.delete(params[:id])
  	render json: { status: :ok }
  end

  private

  def review_params
  	params.require(:review).permit(:body, :rating)
  end
end
