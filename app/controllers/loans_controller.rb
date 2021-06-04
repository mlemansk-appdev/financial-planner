class LoansController < ApplicationController
  before_action :set_loan, only: %i[ show edit update destroy ]
  after_action :verify_policy_scoped, only: [:index]
  after_action :verify_authorized, except: [:index]


   def index
      #Replaced with Pundit Scope
      #@loans = current_user.loans
      @loans = policy_scope(Loan)

      @loans.index_page_charts

    render
  end

  def show
    #Pundit 
    authorize @loan


    @pmt_schedule = @loan.pay_schedule;
    @pmt_schedule_adj = @loan.adj_pay_schedule(@loan.adjustments)
    
    @pmt_schedule_chart =  @pmt_schedule.map{|t| [ t["pmt_no"], t["beg_balance"] ] };
    @adj_pmt_schedule_chart = @pmt_schedule_adj.map{|t| [ t["pmt_no"], t["beg_balance_adj"] ] };

    render
  end

  def new
    @loan = Loan.new
    authorize @loan
  end

  def create 
    @loan = Loan.new(loan_params)
    authorize @loan

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: "Loan was successfully created." }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @loan
    render
  end

  def update
    authorize @loan
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: "Loan was successfully updated." }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @loan
    @loan.destroy

    respond_to do |format|
      format.html { redirect_to loans_url, notice: "Loan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(:current_balance, :original_amount, :interest_rate, :periods_in_year, :user_id, :loan_name, :monthly_min_payment, :schedule_hash, :adj_schedule_hash)
    end
end
