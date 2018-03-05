require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'DB Table' do
    it { should have_db_column :id }
    it { should have_db_column :provider }
    it { should have_db_column :uid }
    it { should have_db_column :encrypted_password }
    it { should have_db_column :reset_password_token }
    it { should have_db_column :reset_password_sent_at }
    it { should have_db_column :remember_created_at }
    it { should have_db_column :sign_in_count }
    it { should have_db_column :current_sign_in_at }
    it { should have_db_column :last_sign_in_at }
    it { should have_db_column :current_sign_in_ip }
    it { should have_db_column :last_sign_in_ip }
    it { should have_db_column :confirmation_token }
    it { should have_db_column :confirmed_at }
    it { should have_db_column :confirmation_sent_at }
    it { should have_db_column :unconfirmed_email }
    it { should have_db_column :name }
    it { should have_db_column :nickname }
    it { should have_db_column :image }
    it { should have_db_column :email }
    it { should have_db_column :created_at }
    it { should have_db_column :updated_at }
  end

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }

    context "should not allow the following emails" do
      emails = ['hey.com', '@.com', 'bobo', 'bobo.com@']
      emails.each do |email|
        it { should_not allow_value(email).for :email }
      end
    end
  end

  describe FactoryBot do
    it "should be valid" do
      expect(FactoryBot.create(:user)).to be_valid
    end
  end
end
