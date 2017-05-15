class Auction < ApplicationRecord

  belongs_to :user
  has_many :bids, dependent: :destroy
  # has_many :favorites, through: :users

  before_save :capitalize_title

  validates :title,       { presence: true}
  validates :description, { presence: true}
  validates :price,       { presence: true,
                            numericality: { greater_than_or_equal_to: 1 }}
                            # greater than bid.price


  private

  def set_defaults
    self.price ||= 1
  end

  def capitalize_title
    self.title.capitalize!
  end

end
