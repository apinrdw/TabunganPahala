class HomeController < ApplicationController
  def index
    @donations = current_period ? current_period.donations.order(created_at: :desc) : Donation.none
  end
end
