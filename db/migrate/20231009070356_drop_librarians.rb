class DropLibrarians < ActiveRecord::Migration[7.0]
  def change
    drop_table :librarians
  end
end
