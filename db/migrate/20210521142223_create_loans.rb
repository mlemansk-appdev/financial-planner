class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.float :current_balance
      t.float :original_amount
      t.float :interest_rate
      t.integer :periods_in_year
      t.integer :user_id
      t.string :loan_name
      t.float :monthly_min_payment
      t.jsonb :schedule_hash
      t.jsonb :adj_schedule_hash

      t.timestamps
    end
  end
end
