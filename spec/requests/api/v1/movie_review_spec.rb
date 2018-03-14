require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :request do 
	let(:user) { FactoryBot.create(:user) }
	let(:credentials) { user.create_new_auth_token }
	let(:headers) { { HTTP_ACCEPT: 'application/json ' }.merge!(credentials) }  
	before do
		3.times { FactoryBot.create(:movie) }
	end

	describe '/api/v1/movies/:movie_id/reviews' do 
		it 'should create a review for a specific movie' do
			post "/api/v1/movies/#{Movie.first.id}/reviews", params: {
				review: { body: 'Movie was truly fantastic' }
			}, headers: headers

			expect(response.status).to eq 200
		end
	end

	describe '/api/v1/movies/:movie_id/reviews' do
		before do
			FactoryBot.create(:review, user: user, movie: Movie.first)
		end
		
		it 'should delete a review for a specific movie' do
			delete "/api/v1/movies/#{Movie.first.id}/reviews/#{Movie.first.reviews.first.id}", headers: headers

			expect(response.status).to eq 200
		end
	end
end