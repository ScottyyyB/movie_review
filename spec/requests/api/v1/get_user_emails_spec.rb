require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :request do
	before do
		5.times { FactoryBot.create(:user, email: "#{Faker::Name.first_name}@gmail.com") }
	end

	describe 'GET /api/v1/auth/emails' do
		it 'should return all user emails' do
			get '/api/v1/auth/emails'

			expect(response.status).to eq 200
			expect(response_json).to eq  ["#{User.first.email}", "#{User.second.email}", "#{User.third.email}", "#{User.fourth.email}", "#{User.fifth.email}"]
		end		
	end
end