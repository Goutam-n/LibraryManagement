class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  # validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  has_many :borrowings
  has_many :books, through: :borrowing

  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?

  def promote_to_admin
    update(role: :admin)
  end

  private

  def set_default_role
    self.role ||= :user
  end
  
end
