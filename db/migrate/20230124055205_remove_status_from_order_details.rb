class RemoveStatusFromOrderDetails < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_details, :status, :integer
  end
end
