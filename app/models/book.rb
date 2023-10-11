class Book < ApplicationRecord
  has_many :borrowings
  has_many :users, through: :borrowings

	validates :title, :author, presence: true
end
