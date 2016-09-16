# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  post_title :string
#  post_text  :text
#  user_id    :integer
#  visible    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe Post, type: :model do
  
  context 'associations' do
    it { should have_many(:comments) #.dependent(:restrict_with_exception) }
  end
  
  context 'To ensure that a column of the database are actually exists' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:post_text).of_type(:string).with_options(:limit => 255)}
    it { should have_db_column(:post_title).of_type(:string).with_options(:limit => 255)}
    it { should have_db_column(:user_id).of_type(:integer)
    it { should have_db_column(:visible).of_type(:integer)
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
    
  it "has a valid factory" do
    post = FactoryGirl.build(:post) 
    post.should be_valid
  end
end
