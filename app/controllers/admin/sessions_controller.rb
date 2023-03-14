class Admin::SessionsController < Admin::AdminController
  before_action :logged_in_user, only: :destroy
  before_action :ensure_admin, only: :destroy

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password]) && @user.admin?
      log_in @user # fix typo here, should be log_in not log in
      redirect_to admin_root_url
    else
      flash.now[:danger] = 'Invalid credentials.'
      render 'new', status: :unprocessable_entity # fix syntax error here, should use symbol instead of string
    end
  end
  
  def destroy
    log_out # change to lowercase, it should be log_out instead of Log_out
    redirect_to admin_login_url
  end

  private
  
  def logged_in_user
    redirect_to admin_root_url unless logged_in?
  end

  def ensure_admin
    redirect_to root_url unless current_user&.admin? # add null checking for current_user
  end
end