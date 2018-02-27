require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  let(:headers) {{ HTTP_ACCEPT: 'application/json' }}

  describe 'POST api/v1/users/sign_up' do
    it 'registers a new user' do
      post '/api/v1/auth', params: {
        email: 'example@test.com', password: 'rightright',
        password_confirmation: 'rightright'
      }, headers: headers

      expect(response.status).to eq 200
      expect(response_json['status']).to eq 'success'
    end
  end
end
