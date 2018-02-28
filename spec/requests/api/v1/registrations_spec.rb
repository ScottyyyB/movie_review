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

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  before do
    2.times { FactoryBot.create(:movie) }
    FactoryBot.create(:movie, title: 'Michael Jordan Legacy')
  end

  describe 'GET /api/v1/movies' do
    it 'should return all movies' do
      get '/api/v1/movies', headers: headers

      expect(response.status).to eq 200
      expect(response_json).to eq expected_response('get_movies.txt')
    end
  end

  describe 'POST /api/v1/movies' do
    it 'should create a new movie' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Once upon a time, there was an old fart...',
          release_date: "#{Date.today}", rating: 'PG-13', director: 'Gandalf'
        }
      }, headers: headers

      expect(response.status).to eq 200
      expect(response_json['message']).to eq 'Gandalf Tales has been successfully created.'
    end

    it 'should not create a new movie if title is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: '', body: 'Once upon a time, there was an old fart...',
          release_date: "#{Date.today}", rating: 'PG-13', director: 'Gandalf'
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Title can\'t be blank'
    end

    it 'should not create a new movie if title is not unique' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Michael Jordan Legacy', body: 'Once upon a time, there was an old fart...',
          release_date: "#{Date.today}", rating: 'PG-13', director: 'Gandalf'
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Title has already been taken'
    end

    it 'should not create a new movie if body is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: '',
          release_date: "#{Date.today}", rating: 'PG-13', director: 'Gandalf'
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Body can\'t be blank'
    end

    it 'should not create a new movie if release date is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Old fart',
          release_date: "", rating: 'PG-13', director: 'Gandalf'
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Release date can\'t be blank'
    end

    it 'should not create a new movie if rating is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Old fart',
          release_date: "#{Date.today}", rating: '', director: 'Gandalf'
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Rating can\'t be blank'
    end

    it 'should not create a new movie if director is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Old fart',
          release_date: "#{Date.today}", rating: 'PG-13', director: ''
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Director can\'t be blank'
    end
  end
end
