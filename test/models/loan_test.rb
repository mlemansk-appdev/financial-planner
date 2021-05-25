# == Schema Information
#
# Table name: loans
#
#  id                  :bigint           not null, primary key
#  current_balance     :float
#  original_amount     :float
#  interest_rate       :float
#  periods_in_year     :integer
#  user_id             :integer
#  loan_name           :string
#  monthly_min_payment :float
#  schedule_hash       :jsonb
#  adj_schedule_hash   :jsonb
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "test_helper"

class LoanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
