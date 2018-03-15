require 'rails_helper'

RSpec.describe Api::V1::RatingsController, type: :request do
	let(:user) { FactoryBot.create(:user) }
	let(:credentials) { user.create_new_auth_token }
	let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

	before do
		3.times { FactoryBot.create(:movie) }
	end

	describe 'POST /api/v1/movies/:movie_id/ratings' do
		it 'should create a rating' do
			post "/api/v1/movies/#{Movie.first.id}/ratings", params: {
				rating: { number: 5 }
			}, headers: headers

			expect(response.status).to eq 200
		end

		it 'should not create a rating if number is blank' do
			post "/api/v1/movies/#{Movie.first.id}/ratings", params: {
				rating: { number: nil }
			}, headers: headers

			expect(response.status).to eq 422
			expect(response_json['errors']).to eq ["Number can't be blank"]
		end
	end

	describe 'DELETE /api/v1/movies/:movie_id/ratings' do
		before do
			FactoryBot.create(:rating, movie: Movie.first, user: user)
		end

		it 'should delete a rating' do
			delete "/api/v1/movies/#{Movie.first.id}/ratings/#{Movie.first.ratings.first.id}", headers: headers

			expect(response.status).to eq 200
		end
	end

	describe 'PUT /api/v1/movies/:movie_id/ratings/:id' do
		before do
			FactoryBot.create(:rating, movie: Movie.first, user: user)
		end

		it 'should update a rating' do
			put "/api/v1/movies/#{Movie.first.id}/ratings/#{Movie.first.ratings.first.id}", params: {
				rating: { number: 4 }
			}, headers: headers

			expect(response.status).to eq 200
		end

		it 'should not update rating if number is blank' do
			put "/api/v1/movies/#{Movie.first.id}/ratings/#{Movie.first.ratings.first.id}", params: {
				rating: { number: nil }
			}, headers: headers

			expect(response.status).to eq 422
		end

		it 'should not update rating if number is not between 1 and 5' do
			put "/api/v1/movies/#{Movie.first.id}/ratings/#{Movie.first.ratings.first.id}", params: {
				rating: { number: nil }
			}, headers: headers

			binding.pry
			expect(response.status).to eq 422
		end
	end
	
end