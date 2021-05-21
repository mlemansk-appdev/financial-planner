require "application_system_test_case"

class AdjustmentsTest < ApplicationSystemTestCase
  setup do
    @adjustment = adjustments(:one)
  end

  test "visiting the index" do
    visit adjustments_url
    assert_selector "h1", text: "Adjustments"
  end

  test "creating a Adjustment" do
    visit adjustments_url
    click_on "New Adjustment"

    fill_in "Adjustment details", with: @adjustment.adjustment_details
    fill_in "Beg pay adj", with: @adjustment.beg_pay_adj
    fill_in "End pay adj", with: @adjustment.end_pay_adj
    fill_in "Loan", with: @adjustment.loan_id
    fill_in "Payment occurrence", with: @adjustment.payment_occurrence
    fill_in "Pmt adjustment", with: @adjustment.pmt_adjustment
    fill_in "User", with: @adjustment.user_id
    click_on "Create Adjustment"

    assert_text "Adjustment was successfully created"
    click_on "Back"
  end

  test "updating a Adjustment" do
    visit adjustments_url
    click_on "Edit", match: :first

    fill_in "Adjustment details", with: @adjustment.adjustment_details
    fill_in "Beg pay adj", with: @adjustment.beg_pay_adj
    fill_in "End pay adj", with: @adjustment.end_pay_adj
    fill_in "Loan", with: @adjustment.loan_id
    fill_in "Payment occurrence", with: @adjustment.payment_occurrence
    fill_in "Pmt adjustment", with: @adjustment.pmt_adjustment
    fill_in "User", with: @adjustment.user_id
    click_on "Update Adjustment"

    assert_text "Adjustment was successfully updated"
    click_on "Back"
  end

  test "destroying a Adjustment" do
    visit adjustments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Adjustment was successfully destroyed"
  end
end
