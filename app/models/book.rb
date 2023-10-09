class Book < ApplicationRecord
    has_many :borrowings
    has_many :users, through: :borrowings
    belongs_to :librarian
end
