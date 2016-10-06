class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_period
    @current_period ||= Period.actives.first
  end
  helper_method :current_period
end
