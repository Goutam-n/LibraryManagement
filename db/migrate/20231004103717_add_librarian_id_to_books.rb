class AddLibrarianIdToBooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :books, :librarian, null: false, foreign_key: true
  end
end
