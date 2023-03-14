class Admin::AdminController < ApplicationController
  layout 'admin'

  def ensure_logged_in
    unless logged_in?
      flash[:danger] = 'Please log in.'
      redirect_to admin_login_url
    end
  end
  
  def ensure_admin
    unless current_user.admin?
      flash[:danger] = 'You cannot access that page.'
      redirect_to root_url
    end
  end
  
end
