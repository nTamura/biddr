class AddOfferToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :offer, :float, default: 1
  end
end
