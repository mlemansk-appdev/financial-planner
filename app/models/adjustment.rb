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
class Adjustment < ApplicationRecord
    belongs_to :loan
    belongs_to :user
    
    validates :loan_id, :presence => true
    validates :pmt_adjustment, :numericality => { :greater_than => 0 }
    validates :pmt_adjustment, :presence => true
    validates :beg_pay_adj, :numericality => { :greater_than => 0 }
    validates :beg_pay_adj, :presence => true
    validates_presence_of :end_pay_adj, :if => lambda { |o| o.payment_occurence == "Between" }
    
end
