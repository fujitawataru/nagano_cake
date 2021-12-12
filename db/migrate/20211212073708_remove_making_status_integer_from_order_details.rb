class RemoveMakingStatusIntegerFromOrderDetails < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_details, :making_status_integer, :string
  end
end
