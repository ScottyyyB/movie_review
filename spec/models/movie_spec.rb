require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'DB Table' do
    it { should have_db_column :id }
    it { should have_db_column :title }
    it { should have_db_column :body }
    it { should have_db_column :release_date }
    it { should have_db_column :rating }
    it { should have_db_column :director }
    it { should have_attached_file :image }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :release_date }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :director }
    it { should validate_attachment_content_type(:image).
                  allowing('image/jpeg') }
    it { should validate_attachment_size(:image).
                  less_than(300.kilobytes) }
  end

  describe FactoryBot do 
    it 'should be valid' do
      expect(FactoryBot.create(:movie, image: fixture_file_upload('files/blade_runner.jpeg'))).to be_valid
    end
  end
end
