require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  let(:headers) {{ HTTP_ACCEPT: 'application/json' }}

  describe 'POST /api/v1/users/sign_up' do
    it 'registers a new user [Happy Path]' do
      post '/api/v1/auth', params: {
        email: 'example@test.com', password: 'rightright',
        password_confirmation: 'rightright'
      }, headers: headers

      expect(response.status).to eq 200
      expect(response_json['status']).to eq 'success'
    end

    it 'does not register a new user if email is invalid' do
       post '/api/v1/auth', params: {
         email: 'hey@', password: 'rightright',
         password_confirmation: 'rightright'
       }, headers: headers

       expect(response.status).to eq 422
       expect(response_json['errors']['full_messages']).to eq ['Email is invalid', 'Email is not an email']
    end

    it 'does not register a new user if password_confirmation does not match password' do
      post '/api/v1/auth', params: {
        email: 'example@test.com', password: 'rightright',
        password_confirmation: 'rightright22'
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors']['full_messages']).to eq ['Password confirmation doesn\'t match Password']
    end

    it 'does not register a new user if password is blank' do
      post '/api/v1/auth', params: {
        email: 'example@test.com', password: '',
        password_confirmation: 'rightright'
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors']['full_messages']).to eq ['Password can\'t be blank', 'Password confirmation doesn\'t match Password']
    end
  end
end
