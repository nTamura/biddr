class Auction < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favoriters, through: :favorites, source: :user
  
  has_many :bids, lambda { order(price: :desc) }, dependent: :destroy
  # has_many :favorites, dependent: :destroy


  before_save :capitalize_title

  validates :title,         { presence: true}
  validates :description,   { presence: true}
  validates :end_date,      { presence: true}
  validates :reserve_price, { presence: true,
                            numericality: { greater_than_or_equal_to: 1 }}
                            # greater than bid.price

  def favorited_by?(user)
    favorites.exists?(user: user)
  end

  def favorite_for(user)
    favorites.find_by(user: user)
  end

  private

  def set_defaults
    self.price ||= 1
  end

  def capitalize_title
    self.title.capitalize!
  end

end
