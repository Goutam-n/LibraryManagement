class CreateBorrowings < ActiveRecord::Migration[7.0]
  def change
    create_table :borrowings do |t|
      t.date :due_date
      t.string :return_status

      t.timestamps
    end
  end
end
