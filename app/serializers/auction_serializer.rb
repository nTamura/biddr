class AuctionSerializer < ActiveModel::Serializer
  attributes :id, :titleized_title, :description
  has_many :bids

  def titleized_title
    object.title.titleize
  end

end
