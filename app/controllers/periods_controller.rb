class PeriodsController < ApplicationController
  semantic_breadcrumb :index, :periods_path

  def index
    @periods = Period.order(created_at: :desc)
  end

  def new
    @period = Period.new
    semantic_breadcrumb :new, new_period_path
  end

  def create
    @period = Period.new(period_params)
    semantic_breadcrumb :new, new_period_path

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
