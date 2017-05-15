class User < ApplicationRecord
  has_secure_password
  has_many :bids, dependent: :nullify
  has_many :auctions, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorited_auctions, through: :favorites, source: :product

  validates :username, { presence: true }
  validates :email, presence: true,
             uniqueness: {case_sensitive: false}

  before_validation :downcase_email

  private

  def downcase_email
    self.email.downcase! if email.present?
  end

end
