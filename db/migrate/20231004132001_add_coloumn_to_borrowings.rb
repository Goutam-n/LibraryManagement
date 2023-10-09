class AddColoumnToBorrowings < ActiveRecord::Migration[7.0]
  def change
    add_reference :borrowings, :user, null: false, foreign_key: true
    add_reference :borrowings, :book, null: false, foreign_key: true
  end
end
