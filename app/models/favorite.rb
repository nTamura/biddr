class Favorite < ApplicationRecord
  belongs_to :auction
  belongs_to :user
end
