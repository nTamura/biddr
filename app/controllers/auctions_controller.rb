class AuctionsController < ApplicationController
  before_action :find_auction, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]

  def new
    @auction = Auction.new
  end

  def create
    auction_params = params.require(:auction).permit([:title, :description, :price])
    @auction = Auction.new auction_params
    @auction.user = current_user

    if @auction.save
      redirect_to auction_path(@auction), notice: 'Auction successfully posted'
    else
      render :new
      flash[:alert] = 'Auction not created'
    end
  end

  def show
    @auction = Auction.find params[:id]
    @auctions = Auction.last(20)
    @bid = Bid.new
  end

  def index
    @auctions = Auction.last(20)
    # @tags = Tag.all
  end

  def edit
    redirect_to root_path, alert: 'Access denied!' unless can? :edit, @auction
    @auction = Auction.find params[:id]
  end

  def update
    @auction = Auction.find params[:id]
    auction_params = params.require(:auction).permit([:title, :description, :price, :category_id, ])

    if !(can? :edit, @auction)
      redirect_to root_path, alert: 'Access denied'
    elsif @auction.update(auction_params)
      redirect_to auction_path(@auction), notice: 'Auction updated'
    end
  end

  def destroy
    auction = Auction.find params[:id]
    # auction.destroy
    if can? :destroy, @auction
      @auction.destroy
      redirect_to auctions_path, notice: 'Auction Deleted'
    end
  end

  private

  def find_auction
    @auction = Auction.find params[:id]
  end

  def auction_params
    params.require(:auction).permit([:title, :description, :price])
  end

end
