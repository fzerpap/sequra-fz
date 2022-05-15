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
      @result = Disburse.get_week_merchant(init_date, end_date, merchant_id)

      render json: @result
      #render json: {status: 200, data: @disburses}
    end

  end

 

  # 
  # POST /disburses - make the calculates the disbursnesements
  def create

    init_date = params[:init_date].to_datetime rescue nil
    end_date = params[:end_date].to_datetime rescue nil
    
    #validdate dates
    if init_date.nil? || end_date.nil?
      @result = {status: 400, message:"Theses dates are not valids"}
    elsif Disburse.validate_week(init_date, end_date) != 'ok'
      @result = {status: 400, message: Disburse.validate_week(init_date, end_date)} 
    elsif Disburse.where('init_date =? and end_date =?',init_date, end_date).any?
      @result = {status: 202, message: 'Info: The calculations were already made for those dates'}
    end
    if @result.nil?
      # invocate backgroun job calculate
      @result = CalculateJob.perform_later(init_date, end_date)
    end
    render json: @result


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
