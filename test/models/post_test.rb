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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
