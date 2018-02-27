require 'rails_helper'

FactoryBot.define do
  factory :user do
    email 'test@example.com'
    password 'rightright'
    password_confirmation 'rightright'
  end
end
