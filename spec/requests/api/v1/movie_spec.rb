require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'GET /api/v1/movies' do
    it 'should return all movies' do
      get '/api/v1/movies', headers: headers

      expect(response.status).to eq 200
      
    end
  end
end
