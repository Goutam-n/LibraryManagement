class User < ApplicationRecord
  has_secure_password

	validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }  

	has_many :borrowings
	has_many :books, through: :borrowing

  enum role: {
    user: 'user',
    librarian: 'admin'
  }

  after_intialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :user
  end 

  def promote_to_admin
    update(role: :librarian)
  end  
end
