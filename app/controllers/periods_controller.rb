class PeriodsController < ApplicationController
  def index
    @periods = Period.order(created_at: :desc)
  end

  def new
    @period = Period.new
  end

  def create
    @period = Period.new(period_params)

    if @period.save
      redirect_to periods_path, notice: 'Period was successfully created.'
    else
      render :new
    end
  end

  def toggle_status
    @period = Period.find(params[:id])
    @period.status = @period.active? ? :inactive : :active

    if @period.save
      redirect_to periods_path, notice: "Period was successfully updated to #{@period.status}"
    else
      redirect_to periods_path, alert: "Error occurred: #{@period.errors.full_messages.join(', ')}"
    end
  end

  private
    def period_params
      params.require(:period).permit(:name, :status)
    end
end
