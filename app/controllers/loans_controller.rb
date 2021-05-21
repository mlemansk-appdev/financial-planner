class LoansController < ApplicationController
  before_action :set_loan, only: %i[ show edit update destroy ]

   def index
    
      @loans = current_user.loans.all
      
      # Initialize Variable
      @pmt_schedule_chart = [];   
      @adj_pmt_schedule_chart = []; 
      @data = []; 
      @data_adj = []; 
      @total_interest = 0;
      @total_adj_interest = 0;
      @pay_off_period = [];
      @pay_off_period_adj = [];
      
       
        
      @loans.each_with_index do |loan , index|
        pmt_schedule = loan.pay_schedule;  
        pmt_schedule_adj = loan.adj_pay_schedule(loan.adjustments);
        @pmt_schedule_chart[index] =  pmt_schedule.map{|t| [ t["pmt_no"], t["beg_balance"] ] };
        @adj_pmt_schedule_chart[index] = pmt_schedule_adj.map{|t| [ t["pmt_no"], t["beg_balance_adj"] ] };
        @data << {name: loan.loan_name , data: @pmt_schedule_chart[index]};
        @data_adj << {name: loan.loan_name , data: @adj_pmt_schedule_chart[index]};
        @total_interest += pmt_schedule[-1].fetch("cum_int");
        @total_adj_interest += pmt_schedule_adj[-1].fetch("cum_int_adj");
        @pay_off_period[index] = pmt_schedule.length;
        @pay_off_period_adj[index] = pmt_schedule_adj.length;
      end
      
  
  
      # Summarize the data for the compare charts
      total_balance = [];
      total_periods = [];
      @total_pmt_schedule_chart = [];
      
      @pmt_schedule_chart.each do |pmt|
        pmt.each_with_index do |period , index|
          if total_balance[index] == nil
              total_balance[index] = 0;
              total_balance[index] += period[1]
          else
              total_balance[index] += period[1]
          end
          
          total_periods[index] = period[0]
          @total_pmt_schedule_chart[index] = [total_periods[index] ,total_balance[index].round(2) ]
        end
      end
      
      total_adj_balance = [];
      total_adj_periods = [];
      @total_adj_pmt_schedule_chart = [];
      
      @adj_pmt_schedule_chart.each do |pmt|
        pmt.each_with_index do |period , index|
          if total_adj_balance[index] == nil
              total_adj_balance[index] = 0;
              total_adj_balance[index] += period[1]
          else
              total_adj_balance[index] += period[1]
          end
          
          total_adj_periods[index] = period[0]
          @total_adj_pmt_schedule_chart[index] = [total_adj_periods[index] ,total_adj_balance[index].round(2) ]
        end
      end
    

    render
  end

  def show
  
    @pmt_schedule = @loan.pay_schedule;
    @pmt_schedule_adj = @loan.adj_pay_schedule(@loan.adjustments)
    
    @pmt_schedule_chart =  @pmt_schedule.map{|t| [ t["pmt_no"], t["beg_balance"] ] };
    @adj_pmt_schedule_chart = @pmt_schedule_adj.map{|t| [ t["pmt_no"], t["beg_balance_adj"] ] };

    render
  end

  def new
    @loan = Loan.new

    render
  end

  def create
    @loan = Loan.new(loan_params)

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
    @loan = Loan.find(params.fetch("id"))

    render
  end

  def update

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
