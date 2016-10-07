class DonationsController < ApplicationController
  before_action :set_period
  before_action :set_donation, only: [:edit, :update, :destroy]
  before_action :set_breadcrumbs

  def index
    @donations = @period.donations.order(created_at: :desc)
  end

  def new
    semantic_breadcrumb :new, new_period_donation_path(@period)
    @donation = @period.donations.new
  end

  def edit
    semantic_breadcrumb :edit, edit_period_donation_path(@period, @donation)
  end

  def create
    semantic_breadcrumb :new, new_period_donation_path(@period)
    @donation = @period.donations.new(donation_params)

    if @donation.save
      donation_broadcast
      redirect_to form_redirection_path, notice: 'Donation was successfully created.'
    else
      render :new
    end
  end

  def update
    semantic_breadcrumb :edit, edit_period_donation_path(@period, @donation)

    if @donation.update(donation_params)
      donation_broadcast
      redirect_to form_redirection_path, notice: 'Donation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @donation.destroy
      donation_broadcast
      redirect_to period_donations_path(@period), notice: 'Donation was successfully destroyed.'
    end
  end

  private
    def set_period
      @period = Period.find(params[:period_id])
    end

    def set_donation
      @donation = @period.donations.find(params[:id])
    end

    def set_breadcrumbs
      semantic_breadcrumb "Donations - #{@period.name}", period_donations_path(@period)
    end

    def donation_params
      params.require(:donation).permit(:receipt_no, :name, :address, :phone, :amount)
    end

    def form_redirection_path
      params[:save_add_new].present? ? new_period_donation_path(@period) : period_donations_path(@period)
    end

    def donation_broadcast
      ActionCable.server.broadcast DonationChannel::CHANNEL_NAME,
        donation: @donation.to_json(only: [:id, :name, :amount]),
        action: action_name
    end
end
