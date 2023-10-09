class RemoveColumnFromLibrarians < ActiveRecord::Migration[7.0]
  def change
    remove_column :librarians, :password_digest, :string
  end
end
