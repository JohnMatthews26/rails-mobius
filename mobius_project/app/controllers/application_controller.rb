class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :transaction_process

  private

  def logged_in?
    !current_user.nil?
  end

  def transaction_process(receiver_id, amount)
    current_user.remove_tokens(amount)
    user = User.find(receiver_id)
    user.lock!
    user.add_tokens(amount)
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def login!(user)
    session[:session_token] = user.session_token
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
end
