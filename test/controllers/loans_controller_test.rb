require "test_helper"

class LoansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loan = loans(:one)
  end

  test "should get index" do
    get loans_url
    assert_response :success
  end

  test "should get new" do
    get new_loan_url
    assert_response :success
  end

  test "should create loan" do
    assert_difference('Loan.count') do
      post loans_url, params: { loan: { adj_schedule_hash: @loan.adj_schedule_hash, current_balance: @loan.current_balance, interest_rate: @loan.interest_rate, loan_name: @loan.loan_name, monthly_min_payment: @loan.monthly_min_payment, original_amount: @loan.original_amount, periods_in_year: @loan.periods_in_year, schedule_hash: @loan.schedule_hash, user_id: @loan.user_id } }
    end

    assert_redirected_to loan_url(Loan.last)
  end

  test "should show loan" do
    get loan_url(@loan)
    assert_response :success
  end

  test "should get edit" do
    get edit_loan_url(@loan)
    assert_response :success
  end

  test "should update loan" do
    patch loan_url(@loan), params: { loan: { adj_schedule_hash: @loan.adj_schedule_hash, current_balance: @loan.current_balance, interest_rate: @loan.interest_rate, loan_name: @loan.loan_name, monthly_min_payment: @loan.monthly_min_payment, original_amount: @loan.original_amount, periods_in_year: @loan.periods_in_year, schedule_hash: @loan.schedule_hash, user_id: @loan.user_id } }
    assert_redirected_to loan_url(@loan)
  end

  test "should destroy loan" do
    assert_difference('Loan.count', -1) do
      delete loan_url(@loan)
    end

    assert_redirected_to loans_url
  end
end
