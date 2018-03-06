class Api::V1::MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies, each_serializer: MovieSerializer
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      binding.pry
      render json: { message: "#{@movie.title} has been successfully created." }
    else
      @movie.errors.delete(:image)
      render json: { errors: @movie.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.delete
    render status: 200
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :body, :release_date, :rating, :director, :image)
  end
end
