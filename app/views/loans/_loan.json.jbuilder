json.extract! loan, :id, :current_balance, :original_amount, :interest_rate, :periods_in_year, :user_id, :loan_name, :monthly_min_payment, :schedule_hash, :adj_schedule_hash, :created_at, :updated_at
json.url loan_url(loan, format: :json)
