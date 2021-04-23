class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /accounts
  # GET /accounts.json
  def index
    if current_user.test_admin
      @accounts = Account.order(sort_column + " " + sort_direction)
    else
      @accounts = Account.where(:user_id => current_user.id)
    end

  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @accounts = Account.find(params[:id])
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    # post by the user on the NEW form
    @income = @account.income.to_f
    @expenses = @account.expenses.to_f

    # check if it is a new entry for that user
    if Account.where(:user_id => @account.user_id).count > 0

      # get the last values from that user from the database
      @old_account = Account.where(:user_id => @account.user_id).last
      @balance = @old_account.balance.to_f
      @prev_balance = @old_account.prev_balance.to_f

      # make the calculations for the new values
      @prev_balance = @balance
      @balance = @prev_balance + @income - @expenses
    else
      @prev_balance = 0.0
      @balance = @income - @expenses
    end

    @account.prev_balance = @prev_balance
    @account.income = @income
    @account.expenses = @expenses
    @account.balance = @balance

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: 'A nova atividade foi adicionada com sucesso.' }
        #format.html { redirect_to @accounts }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update

    @target_line = Account.find(params[:id])
    @new_values = Account.new(account_params)

    # get the user id and the line id
    target_user_id = @target_line.user_id
    target_line_id = @target_line.id

    # set new description
    @target_line.note = @new_values.note
    
    # reset values for target line
    #@target_line.prev_balance = @target_line.prev_balance.to_f + @target_line.expenses.to_f - @target_line.income.to_f
    @target_line.expenses = 0
    @target_line.income = 0
    @target_line.balance = @target_line.prev_balance.to_f
    
    # set new values for target line
    @target_line.expenses = @new_values.expenses.to_f
    @target_line.income = @new_values.income.to_f
    @target_line.balance = @target_line.prev_balance.to_f + @target_line.income.to_f - @target_line.expenses.to_f
    
    # set new values for prev_balance and balance for next lines
    upd_next_line(target_user_id, target_line_id, @target_line.balance)

    respond_to do |format|
      if @target_line.save
        format.html { redirect_to accounts_path, notice: 'A atividade foi atualizada com sucesso.' }
        #format.html { redirect_to @account }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy

    # get all fields of the target line
    @target_line = Account.find(params[:id])

    # If there are two or more entries for that client, an update of the following entries is required 
    if Account.where(:user_id == @target_line.user_id).count > 1

      upd_next_line(@target_line.user_id, @target_line.id, @target_line.prev_balance)
    
    end

    respond_to do |format|
      if @target_line.destroy
        format.html { redirect_to accounts_path, notice: 'A atividade foi excluída com sucesso.' }
        #format.html { redirect_to accounts_url }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(
        :id, :prev_balance, :balance, :income, :expenses, :note, :user_id, 
        user_attributes: [ :id, :first_name, :last_name ] 
      )
    end

    def sort_column
      Account.column_names.include?(params[:sort]) ? params[:sort] : "user_id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def upd_next_line(user_id, line_id, val)
      # If there are two or more entries for that client, an update of the following entries is required 
      if Account.where(:user_id == user_id).count > 1

        # for each entry from the target user after the target line we need to update the values for prev_balance and balance
        # nextlinestoupd = Array.new
        # find every entry after the one selected to be changed and change them
        Account.find_by_sql("Select * from accounts where accounts.user_id = #{user_id} and accounts.id > #{line_id}").each do |nextline|
          updline = Account.find(nextline.id)
          updline.prev_balance = val.to_f
          updline.balance = updline.prev_balance.to_f + nextline.income.to_f - nextline.expenses.to_f
          val = updline.balance.to_f
          updline.save
        end
    end

  end
end