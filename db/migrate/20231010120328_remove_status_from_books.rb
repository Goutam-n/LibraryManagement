class RemoveStatusFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :status, :string
  end
end
