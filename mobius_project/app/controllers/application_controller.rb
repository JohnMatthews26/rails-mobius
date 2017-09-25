class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :current_user_balance

  private

  def logged_in?
    !current_user.nil?
  end

  def current_user_balance
    debits = Transaction.where(sender_id: current_user.id).reduce(0) {|acc, el| acc += el.amount}
    credits = Transaction.where(receiver_id: current_user.id).reduce(0) {|acc, el| acc += el.amount}
    balance = 100 + credits - debits
    return balance
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
