class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:token]
      @current_user ||= User.find_by(token: session[:token])
    else
      @current_user = nil
    end
  end
end
