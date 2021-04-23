class ReportsController < ApplicationController
  before_action only: [:show]
  helper_method :sort_column, :sort_direction

  def index
    if current_user.test_admin
      @report = Account.order(sort_column + " " + sort_direction)
    else
      @report = Account.where(:user_id => current_user.id)
    end
  end

  def show
    if current_user.test_admin
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
    @balance_actual = @user.account.last
  end
  
  
  def sort_column
    Account.column_names.include?(params[:sort]) ? params[:sort] : "user_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
