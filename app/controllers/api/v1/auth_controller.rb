class Api::V1::AuthController < ApplicationController
  def emails
  	emails = []
  	User.all.each { |user| emails << user.email }
  	render json: emails
  end
end
