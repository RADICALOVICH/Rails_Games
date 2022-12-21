class User < ApplicationRecord
  attr_accessor :old_password
  
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true, allow_blank: true

  validate :password_presence
  validate :correct_old_password, on: :update

  private

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'Не верный'
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end
end
