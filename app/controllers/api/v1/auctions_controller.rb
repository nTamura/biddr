class Api::V1::AuctionsController < ApplicationController
  before_action :authenticate_user

  def index
    @auction = Auction.all
  end

  def show
    auction = Auction.find params[:id]
    render json: auction
  end

  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    head :unauthorized if @user.nil?
  end

end
