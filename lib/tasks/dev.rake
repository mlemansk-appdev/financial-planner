desc "Fill the database tables with some sample data"
task({ :sample_data => :environment}) do
  
  User.destroy_all
  Loan.destroy_all
  Adjustment.destroy_all

  # Create Sample Users
    #  email                  :string           default(""), not null
    #  encrypted_password     :string           default(""), not null

  user_hashes = [
    { email: "alice@example.com", password: "password" },
    { email: "bob@example.com", password: "password" },
    { email: "carol@example.com", password: "password" }
  ]

  User.create(user_hashes)


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
    EXAMPLE_ORIGINAL_BALANCES = [1000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000]
    EXAMPLE_INTEREST_RATES = [2, 3, 4, 5, 6]
    EXAMPLE_PAYBACK_IN_YEARS = [2, 4, 6]
    EXAMPLE_PERIODS_IN_A_YEAR  = 12
    users = User.all
    EXAMPLE_LOAN_NAMES = ["Car", "Car 2", "Student Loan", "Grad School", "Credit Card"]

    10.times do
      loan = Loan.new
      loan.current_balance = EXAMPLE_ORIGINAL_BALANCES.sample
      loan.original_amount = loan.current_balance
      loan.interest_rate = EXAMPLE_INTEREST_RATES.sample
      loan.periods_in_year = EXAMPLE_PERIODS_IN_A_YEAR
      loan.user = users.sample
      loan.loan_name = EXAMPLE_LOAN_NAMES.sample
      
      # variables for min payments
      rate = loan.interest_rate/100/12
      periods = EXAMPLE_PAYBACK_IN_YEARS.sample * loan.periods_in_year

      loan.monthly_min_payment = loan.monthly_min_payment_for_payback_period(EXAMPLE_PAYBACK_IN_YEARS.sample)

      loan.save
      p loan.errors.full_messages if loan.errors.any?
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
    EXAMPLE_ADJUSTMENT_AMOUNTS = [50, 100, 150, 200, 250, 300, 400, 500]
    EXAMPLE_BEGINNING_ADJUSTMENT_PERIOD = [1, 5, 10, 12, 18]
    EXAMPLE_AJUSTMENT_LENGTHS = [3, 4, 5, 12]
    EXAMPLE_DETAILS = ["Bonus", "Extra", "Budget", "Adjustment 1", "Adjustment 2", "Adjustment 3", "Adjustment 4" ]

    10.times do
      adjustment = Adjustment.new
      adjustment.payment_occurrence = type.sample
      owner = users.sample
      adjustment.loan_id = owner.loans.sample.id 
      adjustment.user_id = owner.id
      adjustment.pmt_adjustment = EXAMPLE_ADJUSTMENT_AMOUNTS.sample
      adjustment.beg_pay_adj = EXAMPLE_BEGINNING_ADJUSTMENT_PERIOD.sample
      adjustment.end_pay_adj = adjustment.beg_pay_adj + EXAMPLE_AJUSTMENT_LENGTHS.sample
      adjustment.adjustment_details = EXAMPLE_DETAILS.sample
      adjustment.save
      
      p adjustment.errors.full_messages if adjustment.errors.any?

    end    
    p "Added #{Adjustment.count} Adjustments"
end