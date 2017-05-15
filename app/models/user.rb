class User < ApplicationRecord
  has_secure_password
  before_create :generate_api_token

  has_many :bids, dependent: :nullify
  has_many :bidded_auctions, through: :bids, source: :auction
  has_many :auctions, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorited_auctions, through: :favorites, source: :auction

  validates :username, { presence: true }
  validates :email, presence: true,
             uniqueness: {case_sensitive: false}

  before_validation :downcase_email

  private

  def downcase_email
    self.email.downcase! if email.present?
  end

  def generate_api_token
    loop do
      self.api_token = SecureRandom.urlsafe_base64(32)
      break unless User.exists?(api_token: self.api_token)
    end
  end

end
