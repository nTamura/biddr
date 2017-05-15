class Favorite < ApplicationRecord
  belongs_to :auction
  belongs_to :user

  validates :user_id, uniqueness: { scope: :auction_id }
end
