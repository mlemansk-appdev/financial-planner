class AdjustmentsController < ApplicationController
  before_action :set_adjustment, only: %i[ show edit update destroy ]

  # GET /adjustments or /adjustments.json
  def index
    @adjustments = Adjustment.all
  end

  # GET /adjustments/1 or /adjustments/1.json
  def show
  end

  # GET /adjustments/new
  def new
    @adjustment = Adjustment.new
  end

  # GET /adjustments/1/edit
  def edit
  end

  # POST /adjustments or /adjustments.json
  def create
    @adjustment = Adjustment.new(adjustment_params)

    respond_to do |format|
      if @adjustment.save
        format.html { redirect_to @adjustment, notice: "Adjustment was successfully created." }
        format.json { render :show, status: :created, location: @adjustment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adjustments/1 or /adjustments/1.json
  def update
    respond_to do |format|
      if @adjustment.update(adjustment_params)
        format.html { redirect_to @adjustment, notice: "Adjustment was successfully updated." }
        format.json { render :show, status: :ok, location: @adjustment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adjustments/1 or /adjustments/1.json
  def destroy
    @adjustment.destroy
    respond_to do |format|
      format.html { redirect_to adjustments_url, notice: "Adjustment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adjustment
      @adjustment = Adjustment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def adjustment_params
      params.require(:adjustment).permit(:payment_occurrence, :loan_id, :user_id, :pmt_adjustment, :beg_pay_adj, :end_pay_adj, :adjustment_details)
    end
end
