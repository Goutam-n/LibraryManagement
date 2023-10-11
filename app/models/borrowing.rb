class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :user

	validates :due_date, :user_id, :book_id, presence: true
end
