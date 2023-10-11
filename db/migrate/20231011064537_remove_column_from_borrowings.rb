class RemoveColumnFromBorrowings < ActiveRecord::Migration[7.0]
  def change
    remove_column :borrowings, :return_status, :string
  end
end
