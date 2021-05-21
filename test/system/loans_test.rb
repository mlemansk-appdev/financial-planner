require "application_system_test_case"

class LoansTest < ApplicationSystemTestCase
  setup do
    @loan = loans(:one)
  end

  test "visiting the index" do
    visit loans_url
    assert_selector "h1", text: "Loans"
  end

  test "creating a Loan" do
    visit loans_url
    click_on "New Loan"

    fill_in "Adj schedule hash", with: @loan.adj_schedule_hash
    fill_in "Current balance", with: @loan.current_balance
    fill_in "Interest rate", with: @loan.interest_rate
    fill_in "Loan name", with: @loan.loan_name
    fill_in "Monthly min payment", with: @loan.monthly_min_payment
    fill_in "Original amount", with: @loan.original_amount
    fill_in "Periods in year", with: @loan.periods_in_year
    fill_in "Schedule hash", with: @loan.schedule_hash
    fill_in "User", with: @loan.user_id
    click_on "Create Loan"

    assert_text "Loan was successfully created"
    click_on "Back"
  end

  test "updating a Loan" do
    visit loans_url
    click_on "Edit", match: :first

    fill_in "Adj schedule hash", with: @loan.adj_schedule_hash
    fill_in "Current balance", with: @loan.current_balance
    fill_in "Interest rate", with: @loan.interest_rate
    fill_in "Loan name", with: @loan.loan_name
    fill_in "Monthly min payment", with: @loan.monthly_min_payment
    fill_in "Original amount", with: @loan.original_amount
    fill_in "Periods in year", with: @loan.periods_in_year
    fill_in "Schedule hash", with: @loan.schedule_hash
    fill_in "User", with: @loan.user_id
    click_on "Update Loan"

    assert_text "Loan was successfully updated"
    click_on "Back"
  end

  test "destroying a Loan" do
    visit loans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Loan was successfully destroyed"
  end
end
