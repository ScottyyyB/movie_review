require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :request do 
	let(:user) { FactoryBot.create(:user) }
	let(:credentials) { user.create_new_auth_token }
	let(:headers) { { HTTP_ACCEPT: 'application/json ' }.merge!(credentials) }  
	before do
		3.times { FactoryBot.create(:movie) }
	end

	describe 'POST /api/v1/movies/:movie_id/reviews' do 
		it 'should create a review' do
			post "/api/v1/movies/#{Movie.first.id}/reviews", params: {
				review: { body: 'Movie was truly fantastic' }
			}, headers: headers

			expect(response.status).to eq 200
		end

		it 'should not create a review if body is blank' do
			post "/api/v1/movies/#{Movie.first.id}/reviews", params: {
				review: { body: nil }
			}, headers: headers

			expect(response.status).to eq 422
		end
	end

	describe 'DELETE /api/v1/movies/:movie_id/reviews' do
		before do
			FactoryBot.create(:review, movie: Movie.first, user: user)
		end
		
		it 'should delete a review for a specific movie' do
			delete "/api/v1/movies/#{Movie.first.id}/reviews/#{Movie.first.reviews.first.id}", headers: headers

			expect(response.status).to eq 200
		end
	end

	describe 'PUT /api/v1/movies/:movie_id/reviews/:id' do
		before do
			FactoryBot.create(:review, movie: Movie.first, user: user)
		end

		it 'should update a review' do
			put "/api/v1/movies/#{Movie.first.id}/reviews/#{Movie.first.reviews.first.id}", params: {
				review: { body: 'Movie was bad' }
			}, headers: headers

			expect(response.status).to eq 200
		end

		it 'should not update a review if body is blank' do
			put "/api/v1/movies/#{Movie.first.id}/reviews/#{Movie.first.reviews.first.id}", params: {
				review: { body: nil }
			}, headers: headers

			expect(response.status).to eq 422
		end
	end
end