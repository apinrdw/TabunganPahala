class HomeController < ApplicationController
  def index
    @donations = current_period.donations.order(created_at: :desc)
  end
end
