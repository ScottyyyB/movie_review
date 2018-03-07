require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:correct_file) { fixture_file_upload('files/blade_runner.jpeg') }
  let(:large_file) { fixture_file_upload('files/clifford_red_dog.jpg') }
  let(:false_file) { fixture_file_upload('files/100w.gif') }

  before do
    2.times { FactoryBot.create(:movie, image: fixture_file_upload('files/blade_runner.jpeg')) }
    FactoryBot.create(:movie, title: 'Michael Jordan Legacy', image: fixture_file_upload('files/blade_runner.jpeg'))
  end

  describe 'GET /api/v1/movies' do
    it 'should return all movies' do
      get '/api/v1/movies', headers: headers

      binding.pry
      expect(response.status).to eq 200
      expect(response_json).to eq expected_response('get_movies.txt')
    end
  end

  describe 'DELETE /api/v1/movies' do
    it 'should delete a movie' do
      delete "/api/v1/movies/#{Movie.first.id}", headers: headers

      expect(response.status).to eq 200
    end
  end

  describe 'POST /api/v1/movies' do
    it 'should create a new movie' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Once upon a time, there was an old fart...',
          release_date: "#{Date.today}", rating: 'PG-13', director: 'Gandalf', image: correct_file
        }
      }, headers: headers

      expect(response.status).to eq 200
      expect(response_json['message']).to eq 'Gandalf Tales has been successfully created.'
    end

    it 'should not create a new movie if image is too large' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Once upon a time, there was an old fart...',
          release_date: "#{Date.today}", rating: 'PG-13',
          director: 'Gandalf', image: large_file
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq "Image file size must be less than 300 KB"
    end

    it 'should not create a new movie if image file name is neither jpg or jpeg' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Once upon a time, there was an old fart...',
          release_date: "#{Date.today}", rating: 'PG-13',
          director: 'Gandalf', image: false_file
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq "Image file name is invalid"
    end

    it 'should not create a new movie if title is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: '', body: 'Once upon a time, there was an old fart...',
          release_date: "#{Date.today}", rating: 'PG-13',
          director: 'Gandalf', image: correct_file
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Title can\'t be blank'
    end

    it 'should not create a new movie if title is not unique' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Michael Jordan Legacy', body: 'Once upon a time, there was an old fart...',
          release_date: "#{Date.today}", rating: 'PG-13',
          director: 'Gandalf', image: correct_file
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Title has already been taken'
    end

    it 'should not create a new movie if body is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: '',
          release_date: "#{Date.today}", rating: 'PG-13', director: 'Gandalf', image: correct_file
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Body can\'t be blank'
    end

    it 'should not create a new movie if release date is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Old fart',
          release_date: "", rating: 'PG-13',
          director: 'Gandalf', image: correct_file
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Release date can\'t be blank'
    end

    it 'should not create a new movie if rating is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Old fart',
          release_date: "#{Date.today}", rating: '',
          director: 'Gandalf', image: correct_file
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Rating can\'t be blank'
    end

    it 'should not create a new movie if director is blank' do
      post '/api/v1/movies', params: {
        movie: {
          title: 'Gandalf Tales', body: 'Old fart',
          release_date: "#{Date.today}", rating: 'PG-13',
          director: '', image: correct_file
        }
      }, headers: headers

      expect(response.status).to eq 422
      expect(response_json['errors'][0]).to eq 'Director can\'t be blank'
    end
  end
end
