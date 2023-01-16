class AddColumnToCustomer < ActiveRecord::Migration[6.1]

  def change
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :first_name_kana, :string
    add_column :customers, :last_name_kana, :string
    add_column :customers, :phone_number, :integer
    add_column :customers, :postcode, :integer
    add_column :customers, :address, :text
    add_column :customers, :is_active, :boolean
  end
end