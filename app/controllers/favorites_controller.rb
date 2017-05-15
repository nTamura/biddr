class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @auctions = user.favorited_auctions

    render 'favorites/index'
  end

  def create
    @auction = Auction.find(params[:auction_id])

    favorite = Favorite.new(user: current_user, auction: @auction)

    if cannot? :favorite, @auction
      redirect_to auction_path(@auction),
      alert: 'Cannot favorite your own auction'
      return
    end

  respond_to do |format|
      if favorite.save
        format.html { redirect_to auction_path(@auction), notice: 'Added to favorites' }
        format.js { render :render_favorite }
      else
        format.html { redirect_to auction_path(@auction), alert: favorite.errors.full_messages.join(', ')}
        format.js { render :render_favorite }
      end
    end
  end

  def destroy
    @auction = Auction.find params[:auction_id]
    favorite = Favorite.find params[:id]

    if cannot? :favorite, @auction
      redirect_to auction_path(@auction),
      alert: 'Cannot favorite your own auction'
      return
    end

    respond_to do |format|
      if favorite.destroy
        format.html { redirect_to auction_path(@auction), notice: 'Unliked question' }
        format.js   { render :render_favorite }
      else
        format.html { redirect_to auction_path(@auction), alert: like.errors.full_messages.join(', ') }
        format.js   { render :render_favorite }
      end
    end
  end

end
