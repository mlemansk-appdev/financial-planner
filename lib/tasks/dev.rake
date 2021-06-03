desc "Fill the database tables with some sample data"
task({ :sample_data => :environment}) do
  
  User.destroy_all
  Loan.destroy_all
  Adjustment.destroy_all

  # Create Sample Users
    #  email                  :string           default(""), not null
    #  encrypted_password     :string           default(""), not null
  email = ["alice@example.com", "bob@example.com", "carol@example.com"]

  3.times do |count|
    user = User.new
    user.email = email.at(count)
    user.password = "password"
    user.save
  end

  p "Added #{User.count} Users"

  # Create Sample Loans
    #  current_balance     :float
    #  original_amount     :float
    #  interest_rate       :float
    #  periods_in_year     :integer
    #  user_id             :integer
    #  loan_name           :string
    #  monthly_min_payment :float

    #cur_bal = [1000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000]
    org_bal = [1000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000]
    int_rate = [2, 3, 4, 5, 6]
    payback_per = [2, 4, 6]
    per_in_year = 12
    users = User.all
    l_name = ["Car", "Car 2", "Student Loan", "Grad School", "Credit Card"]

    10.times do
      loan = Loan.new
      loan.current_balance = org_bal.sample
      loan.original_amount = loan.current_balance
      loan.interest_rate = int_rate.sample
      loan.periods_in_year = per_in_year
      loan.user_id = users.sample.id
      loan.loan_name = l_name.sample
      
      # variables for min payments
      rate = loan.interest_rate/100/12
      periods = payback_per.sample * loan.periods_in_year

      loan.monthly_min_payment = loan.original_amount * ( rate*(1 + rate)**periods) / ((1+rate)**periods -1)

      loan.save
    end

    p "Added #{Loan.count} Loans"

  # Create Sample Adjustments
    #  payment_occurrence :string
    #  loan_id            :integer
    #  user_id            :integer
    #  pmt_adjustment     :float
    #  beg_pay_adj        :integer
    #  end_pay_adj        :integer
    #  adjustment_details :string

    type = ["Recurring", "One Time", "Between"]
    loans = Loan.all
    adj = [50, 100, 150, 200, 250, 300, 400, 500]
    beg_adj = [1, 5, 10, 12, 18]
    end_adj = [3, 4, 5, 12]
    details = ["Bonus", "Extra", "Budget", "Adjustment 1", "Adjustment 2", "Adjustment 3", "Adjustment 4" ]

    10.times do
      adjustment = Adjustment.new
      adjustment.payment_occurrence = type.sample
      owner = users.sample
      adjustment.loan_id = owner.loans.sample.id 
      adjustment.user_id = owner.id
      adjustment.pmt_adjustment = adj.sample
      adjustment.beg_pay_adj = beg_adj.sample
      adjustment.end_pay_adj = adjustment.beg_pay_adj + end_adj.sample
      adjustment.adjustment_details = details.sample
      adjustment.save

    end    
    p "Added #{Adjustment.count} Adjustments"
end