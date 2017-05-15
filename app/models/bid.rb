class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :user
  validates :price, presence: true, numericality: {greater_than: :auction_offer}


  def auction_offer
    auction.offer
  end
end
