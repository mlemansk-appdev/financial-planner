# == Schema Information
#
# Table name: adjustments
#
#  id                 :bigint           not null, primary key
#  payment_occurrence :string
#  loan_id            :integer
#  user_id            :integer
#  pmt_adjustment     :float
#  beg_pay_adj        :integer
#  end_pay_adj        :integer
#  adjustment_details :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "test_helper"

class AdjustmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
