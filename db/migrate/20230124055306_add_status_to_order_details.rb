class AddStatusToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :status, :integer, null: false, default: 0
  end
end
