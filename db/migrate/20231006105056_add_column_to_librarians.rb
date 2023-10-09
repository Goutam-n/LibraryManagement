class AddColumnToLibrarians < ActiveRecord::Migration[7.0]
  def change
    add_column :librarians, :password_digest, :string
  end
end
