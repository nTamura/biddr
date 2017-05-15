class AddHighestBidToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :highest_bid, :float, default: 1
  end
end
