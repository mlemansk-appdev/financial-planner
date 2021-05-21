class CreateAdjustments < ActiveRecord::Migration[6.1]
  def change
    create_table :adjustments do |t|
      t.string :payment_occurrence
      t.integer :loan_id
      t.integer :user_id
      t.float :pmt_adjustment
      t.integer :beg_pay_adj
      t.integer :end_pay_adj
      t.string :adjustment_details

      t.timestamps
    end
  end
end
