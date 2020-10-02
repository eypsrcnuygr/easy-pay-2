class AddColumnToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :transaction_status, :boolean
  end
end
