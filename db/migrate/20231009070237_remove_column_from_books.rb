class RemoveColumnFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :librarian_id, :integer
  end
end
