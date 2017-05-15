class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :user
  validates :price, presence: true, numericality: {greater_than: :highest_bid}


  def highest_bid
    auction.highest_bid
  end
end
