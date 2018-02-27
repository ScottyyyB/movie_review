require 'rails_helper'

RSpec.describe 'User Sessions', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }


  describe 'POST /api/v1/auth/sign_in' do
    it 'should create session for user' do
      post '/api/v1/auth/sign_in', params: {
        email: user.email,
        password: user.password
      }, headers: headers

      expected_response = eval(file_fixture('user_login.txt').read)
      expect(response.status).to eq 200
      expect(response_json).to eq expected_response.as_json
    end

    it 'should not create session for user if password is incorrect' do
      post '/api/v1/auth/sign_in', params: {
        email: user.email,
        password: 'rightboyos'
      }, headers: headers

      expect(response.status).to eq 401
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end

    it 'should not create session for user if email is incorrect' do
      post '/api/v1/auth/sign_in', params: {
      email: 'hey',
      password: user.password
      }, headers: headers

      expect(response.status).to eq 401
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end

  describe 'DELETE /api/v1/auth/sign_out' do
    before do
      login_as(user, scope: :user)
    end

    it 'should sign out user' do
      delete '/api/v1/auth/sign_out', params: {
        user: user
      }, headers: headers

      expect(response.status).to eq 200
      expect(response_json['success']).to eq true
    end
  end
end
