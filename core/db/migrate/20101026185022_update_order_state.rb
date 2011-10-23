class UpdateOrderState < ActiveRecord::Migration
  def up
    Spree::Order.all.map(&:update!)
  end

  def down
  end
end
