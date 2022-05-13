class Api::V1::DisbursesController < ApplicationController
  before_action :set_disburse, only: %i[ show update destroy ]

  # GET /disburses
  def index
    init_date = params[:init_date].to_datetime rescue nil
    end_date = params[:end_date].to_datetime rescue nil
    merchant_id = params[:merchant_id]

    if init_date.nil? || end_date.nil?
      render json: {message: "Theses dates are not valids"}
    else
      @disburses = Disburse.get_week_merchant(init_date, end_date, merchant_id)

      render json: @disburses
    end

  end

 

  # 
  # POST /disburses - make the calculates the disbursnesements
  def create

    init_date = params[:init_date].to_datetime rescue nil
    end_date = params[:end_date].to_datetime rescue nil

    if init_date.nil? || end_date.nil?
      render json: {message: "Theses dates are not valids"}
    else
      result = Disburse.calculate_disbursements(init_date, end_date)

      render json: {message: result}
    end


  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disburse
      @disburse = Disburse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def disburse_params
      params.require(:disburse).permit(:init_date, :end_date, :orders, :amount, :feed, :merchant_id)
    end
end
