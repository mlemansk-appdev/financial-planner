require "test_helper"

class AdjustmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adjustment = adjustments(:one)
  end

  test "should get index" do
    get adjustments_url
    assert_response :success
  end

  test "should get new" do
    get new_adjustment_url
    assert_response :success
  end

  test "should create adjustment" do
    assert_difference('Adjustment.count') do
      post adjustments_url, params: { adjustment: { adjustment_details: @adjustment.adjustment_details, beg_pay_adj: @adjustment.beg_pay_adj, end_pay_adj: @adjustment.end_pay_adj, loan_id: @adjustment.loan_id, payment_occurrence: @adjustment.payment_occurrence, pmt_adjustment: @adjustment.pmt_adjustment, user_id: @adjustment.user_id } }
    end

    assert_redirected_to adjustment_url(Adjustment.last)
  end

  test "should show adjustment" do
    get adjustment_url(@adjustment)
    assert_response :success
  end

  test "should get edit" do
    get edit_adjustment_url(@adjustment)
    assert_response :success
  end

  test "should update adjustment" do
    patch adjustment_url(@adjustment), params: { adjustment: { adjustment_details: @adjustment.adjustment_details, beg_pay_adj: @adjustment.beg_pay_adj, end_pay_adj: @adjustment.end_pay_adj, loan_id: @adjustment.loan_id, payment_occurrence: @adjustment.payment_occurrence, pmt_adjustment: @adjustment.pmt_adjustment, user_id: @adjustment.user_id } }
    assert_redirected_to adjustment_url(@adjustment)
  end

  test "should destroy adjustment" do
    assert_difference('Adjustment.count', -1) do
      delete adjustment_url(@adjustment)
    end

    assert_redirected_to adjustments_url
  end
end
