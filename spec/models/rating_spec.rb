require 'rails_helper'

RSpec.describe Rating, type: :model do
	describe 'DB Table' do
		it { should have_db_column :id }
		it { should have_db_column :number }
	end

	describe 'Validations' do
		it { should validate_presence_of :number }
	end

	describe 'Relations' do
		it { should belong_to :user }
		it { should belong_to :movie }
	end
end
