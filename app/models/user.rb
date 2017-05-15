class User < ApplicationRecord
  has_secure_password
  has_many :reviews, dependent: :nullify
  has_many :products, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review
  has_many :votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :review

  validates(:first_name, { presence: true })
  validates(:last_name, { presence: true })
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: {case_sensitive: false},
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email
  geocoded_by :address
  after_validation :geocode

  def has_map?
    longitude.present? && latitude.present?
  end

  def self.search(search_term)
    where(['first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?', "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"])
  end

  def self.created_after(date)
    where(['created_at > ?', "#{date}"])
  end

  def self.is_not(name)
    where('first_name != ? AND last_name != ?', "#{name}", "#{name}")
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end

  private

  def downcase_email
    self.email.downcase! if email.present?
  end

end
