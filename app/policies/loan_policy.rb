class LoanPolicy 
  attr_reader :user, :loan

  def initialize(user, loan)
    @user = user
    @loan = loan
  end
  
  def show?
    user.id == loan.user_id
  end

end