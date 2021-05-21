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
