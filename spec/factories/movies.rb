require 'spec_helper'

FactoryBot.define do
  factory :movie do
    title {Faker::Name.title}
    body "MyText"
    release_date "MyString"
    rating "MyString"
    director "MyString"
  end
end
