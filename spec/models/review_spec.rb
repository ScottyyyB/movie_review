require 'rails_helper'

RSpec.describe Review, type: :model do
	describe 'DB Table' do
		it { should have_db_column :id }
		it { should have_db_column :body }
	end

	describe 'Validations' do
		it { should validate_presence_of :body }
	end

	describe 'Relations' do
		it { should belong_to :user }
		it { should belong_to :movie }
	end
end
