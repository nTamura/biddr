class BidSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at
end
