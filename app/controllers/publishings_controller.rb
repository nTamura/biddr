class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def create
    auction = Auction.find params[:auction_id]
    if auction.publish!
      redirect_to auction, notice: 'Auction is published!'
    else
      redirect_to auction, notice: "Could not publish auction."
    end
  end
end
